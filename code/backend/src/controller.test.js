const db = require("../models/index");
const {
  getAllTodos,
  createTodo,
  checkTodo,
  deleteTodo,
} = require("./controller"); // Update the path if necessary

// Mock the db.Todo model
jest.mock("../models/index", () => ({
  Todo: {
    findAll: jest.fn(),
    create: jest.fn(),
    findOne: jest.fn(),
    destroy: jest.fn(),
  },
}));

// Helper function to mock response object
const mockResponse = () => {
  const res = {};
  res.status = jest.fn().mockReturnValue(res);
  res.json = jest.fn().mockReturnValue(res);
  return res;
};

describe("Todo Controller", () => {
  let req;
  let res;

  beforeEach(() => {
    req = {
      body: {},
    };
    res = mockResponse();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe("getAllTodos", () => {
    it("should return all todos", async () => {
      const todos = [{ id: 1, content: "Test todo", isCompleted: false }];
      db.Todo.findAll.mockResolvedValue(todos);

      await getAllTodos(req, res);

      expect(db.Todo.findAll).toHaveBeenCalled();
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({
        code: 100,
        message: "OK",
        todoList: todos,
      });
    });
  });

  describe("createTodo", () => {
    it("should create a new todo", async () => {
      const newTodo = { id: 1, content: "New todo", isCompleted: false };
      req.body.content = "New todo";
      db.Todo.create.mockResolvedValue(newTodo);

      await createTodo(req, res);

      expect(db.Todo.create).toHaveBeenCalledWith({
        content: "New todo",
        isCompleted: false,
      });
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({
        code: 100,
        message: "OK",
        newTodo: newTodo,
      });
    });
  });

  describe("checkTodo", () => {
    it("should toggle the isCompleted status of a todo", async () => {
      const todo = {
        id: 1,
        content: "Test todo",
        isCompleted: false,
        save: jest.fn(),
      };
      req.body.id = 1;
      db.Todo.findOne.mockResolvedValue(todo);

      await checkTodo(req, res);

      expect(db.Todo.findOne).toHaveBeenCalledWith({ where: { id: 1 } });
      expect(todo.isCompleted).toBe(true);
      expect(todo.save).toHaveBeenCalled();
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({
        code: 100,
        message: "OK",
        newTodo: todo,
      });
    });
  });

  describe("deleteTodo", () => {
    it("should delete a todo", async () => {
      req.body.id = 1;
      db.Todo.destroy.mockResolvedValue(1);

      await deleteTodo(req, res);

      expect(db.Todo.destroy).toHaveBeenCalledWith({ where: { id: 1 } });
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({
        code: 100,
        message: "OK",
      });
    });
  });
});
