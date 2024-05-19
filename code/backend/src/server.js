const express = require("express");
const app = express();
require("dotenv").config();
const {
  getAllTodos,
  createTodo,
  checkTodo,
  deleteTodo,
} = require("./controller");
// const initDb = require("../loaders/initDB");
const cors = require("cors");

// add this line to test
// initDb();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const basePath = "/api";
app.get(basePath + "/", (req, res) => {
  res.send("Hello from server");
});

app.get(basePath + "/list", getAllTodos);

app.post(basePath + "/", createTodo);

app.put(basePath + "/", checkTodo);

app.delete(basePath + "/", deleteTodo);

app.listen(3000, () => console.log("App is listening on port 3000"));
