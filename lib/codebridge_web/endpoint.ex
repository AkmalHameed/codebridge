defmodule CodebridgeWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :codebridge

  @session_options [
    store: :cookie,
    key: "_codebridge_key",
    signing_salt: "5Npc9M5D",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/assets",
    from: {:codebridge, "priv/static/assets"},
    gzip: false

  plug Plug.Static,
    at: "/",
    from: {:codebridge, "priv/static"},
    gzip: false,
    only: ~w(fonts images favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :codebridge
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug CodebridgeWeb.Router
end
