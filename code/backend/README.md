# Todo Backend API 

This document describes the API endpoints, and some env config for a Todo backend application. The application provides a simple RESTful API for managing a list of todo items. Below are the details of each endpoint and their respective functionalities.

## API Endpoints

### Get All Todos

- **Endpoint:** `GET /list`
- **Handler Function:** `getAllTodos`
- **Description:** This endpoint retrieves and returns a list of all todo items. It is typically used to display the current todos to the user.

### Create a Todo

- **Endpoint:** `POST /`
- **Handler Function:** `createTodo`
- **Description:** This endpoint creates a new todo item. It accepts a JSON payload with the details of the todo to be created.

### Update a Todo

- **Endpoint:** `PUT /`
- **Handler Function:** `checkTodo`
- **Description:** This endpoint updates an existing todo item, typically marking it as completed. It accepts a JSON payload with the id of the todo and the updated details.

### Delete a Todo

- **Endpoint:** `DELETE /`
- **Handler Function:** `deleteTodo`
- **Description:** This endpoint deletes an existing todo item. It accepts a JSON payload with the id of the todo to be deleted.

---

`.env` file is used to configure environment variables for the application. These variables are essential for setting up the application's runtime environment, particularly for database connection details. Below is a detailed description of each variable:

## Environment Variables for database connection

### NODE_ENV
- **Value:** `production`
- **Description:** Specifies the environment in which the application is running. Common values include `development`, `production`, and `test`. Here, it's set to `production`, indicating that the application is running in a production environment.

### DB_USERNAME
- **Value:** `root`
- **Description:** The username used to connect to the database. In this case, the username is `root`.

### DB_PASSWORD
- **Value:** *(empty)*
- **Description:** The password for the database user. This field is currently empty, which may be suitable for development environments but should be securely set for production.

### DB_DATABASE
- **Value:** `app_database`
- **Description:** The name of the database to which the application will connect. The database name specified here is `app_database`.

### DB_HOST
- **Value:** `127.0.0.1`
- **Description:** The hostname or IP address of the database server. `127.0.0.1` refers to the localhost, indicating that the database server is running on the same machine as the application.

### DB_DIALECT
- **Value:** *(empty)*
- **Description:** The type of database being used (e.g., `mysql`, `postgres`, `sqlite`, etc.). This field is currently empty and should be set according to the database being used.

### DB_LOGGING
- **Value:** *(empty)*
- **Description:** Controls whether SQL query logging is enabled. This field is currently empty and can be set to `true` or `false` to enable or disable logging.

## Example Configuration

An example of a complete `.env` file for a MySQL database might look like this:

```plaintext
NODE_ENV=production
DB_USERNAME=root
DB_PASSWORD=securepassword
DB_DATABASE=app_database
DB_HOST=127.0.0.1
DB_DIALECT=mysql
DB_LOGGING=true
