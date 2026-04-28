defmodule CodebridgeWeb.Router do
  use CodebridgeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :fetch_flash
    plug :put_root_layout, html: {CodebridgeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_auth do
    plug :basic_auth
  end

  defp basic_auth(conn, _opts) do
    username = "admin"
    password = "codebridge2026"

    case Plug.BasicAuth.parse_basic_auth(conn) do
      {^username, ^password} -> conn
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end

  scope "/", CodebridgeWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/program", PageController, :program
    get "/program/module-1", PageController, :module1
    get "/program/module-2", PageController, :module2
    get "/curriculum", PageController, :curriculum
    get "/requirements", PageController, :requirements

    live "/applications", ApplicationLive.Index, :index
    live "/applications/new", ApplicationLive.Form, :new
    live "/applications/:id", ApplicationLive.Show, :show
    live "/applications/:id/edit", ApplicationLive.Form, :edit
  end

  scope "/", CodebridgeWeb do
    pipe_through [:browser, :admin_auth]

    get "/admin", PageController, :admin
    get "/admin/:id", PageController, :admin_show
    put "/admin/:id/review", PageController, :admin_review
  end

  if Application.compile_env(:codebridge, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CodebridgeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
