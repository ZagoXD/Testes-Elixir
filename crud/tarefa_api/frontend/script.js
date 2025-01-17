const apiUrl = "http://localhost:4000/api/tasks";

// Carregar Tarefas ao Iniciar
window.onload = async () => {
  const tasks = await fetchTasks();
  renderTasks(tasks);
};

// Função para Buscar Tarefas
async function fetchTasks() {
    const response = await fetch(apiUrl);
    const json = await response.json();
    return json.data;
  }
  

// Função para Renderizar Tarefas
function renderTasks(tasks) {
  const taskList = document.getElementById("task-list");
  taskList.innerHTML = ""; // Limpar Lista
  tasks.forEach(task => {
    const li = document.createElement("li");
    li.className = task.is_completed ? "completed" : "";
    li.innerHTML = `
      <div>
        <strong>${task.title}</strong>
        <p>${task.description}</p>
      </div>
      <div>
        <button onclick="toggleTask(${task.id}, ${!task.is_completed})">
          ${task.is_completed ? "Reabrir" : "Concluir"}
        </button>
        <button onclick="deleteTask(${task.id})">Excluir</button>
      </div>
    `;
    taskList.appendChild(li);
  });
}

// Adicionar Nova Tarefa
document.getElementById("task-form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const title = document.getElementById("title").value;
  const description = document.getElementById("description").value;
  const is_completed = document.getElementById("is_completed").checked;

  await fetch(apiUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ title, description, is_completed }),
  });

  const tasks = await fetchTasks();
  renderTasks(tasks);

  e.target.reset(); // Limpar Formulário
});

// Atualizar Status da Tarefa
async function toggleTask(id, is_completed) {
  await fetch(`${apiUrl}/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ is_completed }),
  });

  const tasks = await fetchTasks();
  renderTasks(tasks);
}

// Excluir Tarefa
async function deleteTask(id) {
  await fetch(`${apiUrl}/${id}`, { method: "DELETE" });

  const tasks = await fetchTasks();
  renderTasks(tasks);
}
