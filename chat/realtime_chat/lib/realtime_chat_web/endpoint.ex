defmodule RealtimeChatWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :realtime_chat

  # Configuração de sessão
  @session_options [
    store: :cookie,
    key: "_realtime_chat_key",
    signing_salt: "W1lBJybz",
    same_site: "Lax"
  ]

  # Configuração do socket para canais (necessário para WebSocket)
  socket "/socket", RealtimeChatWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Configuração do LiveView socket
  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Configuração de arquivos estáticos
  plug Plug.Static,
    at: "/",
    from: :realtime_chat,
    gzip: false,
    only: RealtimeChatWeb.static_paths()

  # Reload de código em desenvolvimento
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  # Request Logger para LiveDashboard
  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  # Outros plugs essenciais
  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug RealtimeChatWeb.Router
end
