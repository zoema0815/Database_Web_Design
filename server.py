
"""
Columbia's COMS W4111.001 Introduction to Databases
Example Webserver
To run locally:
    python3 server.py
Go to http://localhost:8111 in your browser.
A debugger such as "pdb" may be helpful for debugging.
Read about it online.
"""
import os
from numpy.random import randint
  # accessible as a variable in index.html:
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from flask import Flask, request, render_template, g, redirect, Response, abort

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)

DATABASEURI = "postgresql://..."


#
# This line creates a database engine that knows how to connect to the URI above.
#
engine = create_engine(DATABASEURI, future=True)

#
# Example of running queries in your database
# Note that this will probably not work if you already have a table named 'test' in your database, containing meaningful data. This is only an example showing you how to run queries in your database using SQLAlchemy.
#
conn = engine.connect()

@app.before_request
def before_request():
  """
  This function is run at the beginning of every web request
  (every time you enter an address in the web browser).
  We use it to setup a database connection that can be used throughout the request.

  The variable g is globally accessible.
  """
  try:
    g.conn = engine.connect()
  except:
    print("uh oh, problem connecting to database")
    import traceback; traceback.print_exc()
    g.conn = None

@app.teardown_request
def teardown_request(exception):
  """
  At the end of the web request, this makes sure to close the database connection.
  If you don't, the database could run out of memory!
  """
  try:
    g.conn.close()
  except Exception as e:
    pass


@app.route('/')
def index():
  """
  request is a special object that Flask provides to access web request information:

  request.method:   "GET" or "POST"
  request.form:     if the browser submitted a form, this contains the data in the form
  request.args:     dictionary of URL arguments, e.g., {a:1, b:2} for http://localhost?a=1&b=2

  See its API: https://flask.palletsprojects.com/en/2.0.x/api/?highlight=incoming%20request%20data

  """
  return render_template("index.html")

# let user to input their infomation first
@app.route('/signup', methods=["POST"])
def signup():
  # extract data from front-end
  firstname = request.form['firstname']
  lastname = request.form['lastname']
  email = request.form['email']
  phone = request.form['phone']
  contactid = str(randint(10, 1000))
  rnum = randint(15, 1000)
  customerid = "Customer" + str(rnum)
  address = request.form['address']
  paintid = request.form['favorite_color']

  # insert to customer table first, then the contact_owener table
  params_dict1 = {"customerid":customerid, "address":address}
  g.conn.execute(text('INSERT INTO customer(customerid, address) VALUES (:customerid, :address)'), params_dict1)
  g.conn.commit()
 
  params_dict = {"contactid":contactid, "firstname":firstname, "lastname":lastname, "email":email, "phone":phone, "customerid":customerid}
  g.conn.execute(text('INSERT INTO contact_owner(contactid, firstname, lastname, email, phone,  customerid) VALUES (:contactid, :firstname, :lastname, :email, :phone, :customerid)'), params_dict)
  g.conn.commit()

  params_dict2 = {"customerid":customerid, "paintid":paintid}
  g.conn.execute(text('INSERT INTO favoritecolor(customerid, paintid) VALUES (:customerid, :paintid)'), params_dict2)
  g.conn.commit()
 
  return render_template("select.html")

# handle login users
@app.route('/login', methods =["POST"])
def login():
  email = request.form['email']
  phone = request.form['phone']
  
  query = text("SELECT * FROM contact_owner C WHERE C.email=:email AND C.phone=:phone")
  cursor = g.conn.execute(query, {'email':email, 'phone':phone})
  result = cursor.fetchone()
  g.conn.commit()
  cursor.close()

  if result:
    # login successfully --> jump to user personal page
    # find the customer id and use that id to do more queries
    query = text("SELECT C.customerid FROM contact_owner C WHERE C.email=:email AND C.phone=:phone")
    cursor = g.conn.execute(query, {'email':email, 'phone':phone})
    g.conn.commit()
    customerid_result = cursor.mappings().all()
    cursor.close()

    # app.logger.debug('customerid: %s', type(customerid_result))

    # use customer id to find the order's details
    customerid = customerid_result[0]
    # app.logger.debug('customerid: %s', type(customerid))
    query2 = text("SELECT B.orderid, B.orderdate, M.typename FROM orderhistory_buy B, orders O, scooter_madeby S, modeltype_colorwork M WHERE B.customerid=:customerid AND O.orderid=B.orderid AND O.serialnumber=S.serialnumber AND S.typenumber=M.typenumber")
    cursor = g.conn.execute(query2, customerid)
    g.conn.commit()
    results = cursor.fetchall()
    cursor.close()

    return render_template('history.html', results=results)
  else:
    # redirect to signup page
    return redirect('/')


# then let users to select which products they prefer
@app.route('/prodectselect', endpoint='prodectselect', methods=["POST", "GET"])
def prodectselect():
  sale_status = request.form['sale_status']

  # two scenarios: clearance or new arrivals, select products based on their salepercentage
  # our logic is when the sale % greater and equal than 8%, then it is a new arrival product and vice versa
  # need 2 queries: extracts the names
  cursor = g.conn.execute(text("SELECT typename FROM modeltype_colorwork WHERE salepercentage >= 0.08"))
  g.conn.commit()
  results = cursor.mappings().all()
  newarrivals_name = []
  for r in results:
    newarrivals_name.append(r["typename"])
  cursor.close()

  cursor = g.conn.execute(text("SELECT typename FROM modeltype_colorwork WHERE salepercentage < 0.08"))
  g.conn.commit()
  results = cursor.mappings().all()
  clearance_name = []
  for r in results:
    clearance_name.append(r["typename"])
  cursor.close()
 
  # based on user's selection, displays the names of product
  if sale_status == "clearence" :
    context = dict(data = clearance_name)
  elif sale_status == "new_arrival":
    context = dict(data = newarrivals_name)

  return render_template("select.html", **context)

# display the product info to user
@app.route('/productdetails', endpoint='productdetails', methods=['GET'])
def productdetails():
  selectname = request.args.get('product_name')
  # app.logger.debug('This is a debug message')
  # app.logger.debug('select product: %s', selectname)
 
  # Based on user's selection, we display the details of the product
  # retrieve from sql database
  query = text("SELECT S.serialnumber, M.typename,M.typenumber,S.unitprice,P.colorname,P.colorstyle FROM modeltype_colorwork M,scooter_madeby S,paint P WHERE M.typenumber=S.typenumber AND P.paintid=M.paintid AND M.typename=:selectname")
  cursor = g.conn.execute(query, {'selectname':selectname})
  g.conn.commit()

  results = cursor.fetchall()
  # app.logger.debug('details: %s', results)
  cursor.close()

  return render_template("show.html", results=results)

# finally display the store location and info to user
@app.route('/display_locations/<serial_number>')
def display_locations(serial_number):

  query = text("SELECT R.owner,R.storeid,R.email,R.phone,L.address,L.city,L.state,L.zipcode FROM manages M,retailstore R, locateat_location L WHERE M.storeid=R.storeid AND R.storeid=L.storeid AND M.serialnumber=:serial_number")
  cursor = g.conn.execute(query, {'serial_number':serial_number})
  g.conn.commit()
  results = cursor.fetchall()
  cursor.close()

  return render_template('store.html', results=results)


if __name__ == "__main__":
  import click

  @click.command()
  @click.option('--debug', is_flag=True)
  @click.option('--threaded', is_flag=True)
  @click.argument('HOST', default='0.0.0.0')
  @click.argument('PORT', default=8111, type=int)
  def run(debug, threaded, host, port):

    HOST, PORT = host, port
    print("running on %s:%d" % (HOST, PORT))
    app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)

  run()
