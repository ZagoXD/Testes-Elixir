defmodule RealtimeChatWeb.ChatChannel do
  use Phoenix.Channel

  def join("room:lobby", _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast(socket, "new_msg", %{body: body, username: socket.assigns.username})
    {:noreply, socket}
  end
end
