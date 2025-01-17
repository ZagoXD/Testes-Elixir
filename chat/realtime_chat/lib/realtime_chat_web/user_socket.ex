defmodule RealtimeChatWeb.UserSocket do
  use Phoenix.Socket

  # Define o canal para o chat
  channel "room:lobby", RealtimeChatWeb.ChatChannel

  # Permite a conexão e associa o nome de usuário ao socket
  def connect(%{"username" => username}, socket, _connect_info) do
    {:ok, assign(socket, :username, username)}
  end

  # Retorna `nil` para não identificar o socket de forma global
  def id(_socket), do: nil
end
