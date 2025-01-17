defmodule AuthApiWeb.Router do
  use AuthApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AuthApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthApiWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  pipeline :auth do
    plug Guardian.Plug.Pipeline,
      module: AuthApiWeb.Auth.Guardian,
      error_handler: AuthApiWeb.Auth.ErrorHandler
  end

  # Other scopes may use custom stacks.
  scope "/api", AuthApiWeb do
    pipe_through [:api, :auth]
    post "/register", AuthController, :register
    post "/login", AuthController, :login
    get "/protected", ProtectedController, :index
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:auth_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AuthApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
