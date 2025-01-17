defmodule TarefaApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :tarefa_api

  # Configuração de sessão
  @session_options [
    store: :cookie,
    key: "_tarefa_api_key",
    signing_salt: "jucFd+gM",
    same_site: "Lax"
  ]

  # Configuração do socket
  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Configuração de arquivos estáticos
  plug Plug.Static,
    at: "/",
    from: :tarefa_api,
    gzip: false,
    only: TarefaApiWeb.static_paths()

  # Reload de código em desenvolvimento
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :tarefa_api
  end

  # Configuração do RequestLogger
  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  # Plug para gerenciar CORS
  plug CORSPlug, origin: ["http://127.0.0.1:5500"]

  # Outros plugs
  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  # Plug para roteamento
  plug TarefaApiWeb.Router
end
