# Database Project - Web Front-End Development for PostgreSQL

The SQL database contains only fake data for demonstration purposes.

Here's the main features of our webpage:
- The application prompts users to either sign up or log in. When signing up, customers need to fill out their information, such as name, email, color preference, etc. Users can also log in with their email and phone number.
- If the user exists in our database, the application displays their purchase history, if any, and asks the user if they want to see more products.
- For new users, the application prompts them to choose a product, either from clearance or new arrivals. 
- Based on the sale status attribute under the model type entity, the application provides the name of the model type.
- When the user clicks on the name of a model type, it displays the details of that model type.
- After the customer decides on the model type, the application provides information about the retail stores where the product is available.
- Try this login test case: email = janes@example.com, phone = 555987654

Description:
- Product Detail Page
    - Purpose: This page is used for customers selecting which product they want by showing the details of product.

    - Database Operations: The page executes database queries that involve joining multiple tables, including modeltype_colorwork, scooter_madeby, and paint. Inputs on the page are utilized to present information such as serial number, type name, type number, unit price, color name, and color style. Customers can select their preferred product by clicking on the serial number, which redirects them to another webpage providing information about the store where the selected product is in stock.

    - Why Interesting: The query's complexity is concealed from the user, who merely selects a product name and receives a set of details in return. Customers can choose a product based on color, model type, and price.

- Store Location Page
    - Purpose: This page is used for customers to check the stock information of the store where their selected product is available.

    - Database Operations: When a product name is selected, an SQL query utilizes it as a parameter to join three tables: manages, retailstore, and locateat_location. This query extracts detailed information about the store, including the store owner, store ID, email, phone, address, city, state, and zipcode.

    - Why Interesting: The operation reflects a scenario in which products are tracked using serial numbers, and management and location information is necessary for logistical or customer service purposes. Customers can choose between online shopping and offline shopping by accessing store information on this website.
