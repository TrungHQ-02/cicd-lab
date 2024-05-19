const db = require("../models/index");

let getAllTodos = async (req, res) => {
  let todoList = "";
  try {
    todoList = await db.Todo.findAll();
  } catch (err) {
    console.log(err.message);
  }

  return res.status(200).json({
    code: 100,
    message: "OK",
    todoList,
  });
};

let createTodo = async (req, res) => {
  let newTodo = "";

  // console.log(req.body);

  try {
    newTodo = await db.Todo.create({
      content: req.body.content,
      isCompleted: false,
    });
  } catch (err) {
    console.log(err.message);
  }

  return res.status(200).json({
    code: 100,
    message: "OK",
    newTodo: newTodo,
  });
};

let checkTodo = async (req, res) => {
  let id = req.body.id;
  let todo = "";
  try {
    todo = await db.Todo.findOne({
      where: {
        id: id,
      },
    });

    todo.isCompleted = !todo.isCompleted;
    await todo.save();
  } catch (err) {
    console.log(err.message);
  }

  try {
    todo = await db.Todo.findOne({
      where: {
        id: id,
      },
    });
  } catch (err) {
    console.log(err.message);
  }
  return res.status(200).json({
    code: 100,
    message: "OK",
    newTodo: todo,
  });
};
let deleteTodo = async (req, res) => {
  let id = req.body.id;
  try {
    todo = await db.Todo.destroy({
      where: {
        id: id,
      },
    });
  } catch (err) {
    console.log(err.message);
  }

  return res.status(200).json({
    code: 100,
    message: "OK",
  });
};

module.exports = {
  getAllTodos: getAllTodos,
  createTodo: createTodo,
  checkTodo: checkTodo,
  deleteTodo: deleteTodo,
};
