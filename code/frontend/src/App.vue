<template>
  <main class="app">
    <section class="greeting">
      <h3 class="title">🐳ToDo Application by TrungHQ🐳</h3>
    </section>

    <div class="input-section">
      <section class="create-todo">
        <form @submit.prevent="addTodo">
          <h3>🤡What are you gonna do today?🤡</h3>
          <input
            type="text"
            placeholder="e.g. do kubernetes lab"
            v-model="text"
          />

          <input type="submit" value="Add this task" />
        </form>
      </section>
    </div>

    <div class="todo-section">
      <section class="todo-list">
        <h2 v-show="todos.length === 0">
          🙉 Good job! You have nothing to do 🙉
        </h2>
        <h2 v-show="todos.length !== 0">🙈 Here is your todolist 🙈</h2>

        <div class="list">
          <div
            v-for="todo in todos"
            :class="`todo-item ${todo.isCompleted ? 'done' : ''}`"
          >
            <label>
              <input
                type="checkbox"
                v-model="todo.isCompleted"
                @change="updateTodoStatus(todo)"
              />
            </label>

            <div class="todo-content">
              <input
                type="text"
                v-model="todo.content"
                @change="updateTodoContent(todo)"
              />
            </div>

            <div class="actions">
              <button class="delete" @click="deleteTodo(todo)">Delete</button>
            </div>
          </div>
        </div>
      </section>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
const todos = ref([]);
const text = ref("");

const apiUrl = import.meta.env.VITE_API_BASE_URL;
const env = import.meta.env;
console.log(apiUrl);

console.log(env);

async function addTodo() {
  if (text.value.trim() === "") {
    return;
  }

  const newTodo = {
    content: text.value,
  };

  try {
    const response = await axios.post(`${apiUrl}`, newTodo);
    todos.value.unshift(response.data.newTodo);
    text.value = "";
  } catch (error) {
    console.error("Error adding todo:", error);
  }
}

async function deleteTodo(todo) {
  try {
    await axios.delete(`${apiUrl}`, { data: { id: todo.id } });
    todos.value = todos.value.filter((x) => x !== todo);
  } catch (error) {
    console.error("Error deleting todo:", error);
  }
}

async function updateTodoStatus(todo) {
  try {
    const response = await axios.put(`${apiUrl}`, { id: todo.id });
    const updatedTodo = response.data.newTodo;
    const index = todos.value.findIndex((t) => t.id === updatedTodo.id);
    todos.value.splice(index, 1, updatedTodo);
  } catch (error) {
    console.error("Error updating todo status:", error);
  }
}

async function updateTodoContent(todo) {
  try {
    const response = await axios.put(`${apiUrl}`, {
      id: todo.id,
      content: todo.content,
    });
    const updatedTodo = response.data.newTodo;
    const index = todos.value.findIndex((t) => t.id === updatedTodo.id);
    todos.value.splice(index, 1, updatedTodo);
  } catch (error) {
    console.error("Error updating todo content:", error);
  }
}

onMounted(async () => {
  try {
    const response = await axios.get(`${apiUrl}/list`);
    todos.value = response.data.todoList || [];
  } catch (error) {
    console.error("Error fetching todos:", error);
  }
});
</script>
