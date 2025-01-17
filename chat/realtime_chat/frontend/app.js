
// Conectar ao servidor Phoenix
const username = prompt("Digite seu nome de usuário:");
let socket = new Phoenix.Socket("ws://localhost:4000/socket", { params: { username } });
socket.connect();

// Lidar com reconexões
socket.onError(() => console.log("Erro na conexão do WebSocket."));
socket.onClose(() => console.log("WebSocket desconectado. Tentando reconectar..."));

// Entrar no canal "room:lobby"
let channel = socket.channel("room:lobby", {});

channel.join()
  .receive("ok", () => console.log("Conectado ao canal"))
  .receive("error", () => console.log("Erro ao conectar ao canal"));

// Função para exibir mensagens
function renderMessage(payload) {
  let messageContainer = document.getElementById("messages");
  let messageDiv = document.createElement("div");
  messageDiv.innerText = `${payload.username}: ${payload.body}`;
  messageContainer.appendChild(messageDiv);
}

// Manipular mensagens recebidas
channel.on("new_msg", renderMessage);

// Enviar mensagens
document.getElementById("chat-form").addEventListener("submit", (event) => {
  event.preventDefault();
  let messageInput = document.getElementById("message-input");
  let message = messageInput.value;

  channel.push("new_msg", { body: message });
  messageInput.value = "";
});
