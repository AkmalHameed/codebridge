import Config

config :codebridge, Codebridge.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "codebridge_dev",
  port: 5434,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :codebridge, CodebridgeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "/WB/GePqg3OwnvMS9dsMqAdDMgVF4lf5ornfAVi0qeQLfPRwqerzoPo3p/i9xrYP",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:codebridge, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:codebridge, ~w(--watch)]}
  ],
  live_reload: [
    web_console_logger: true,
    patterns: [
      ~r"priv/static/(?!uploads/).*\.(js|css|png|jpeg|jpg|gif|svg)$"E,
      ~r"priv/gettext/.*\.po$"E,
      ~r"lib/codebridge_web/router\.ex$"E,
      ~r"lib/codebridge_web/(controllers|live|components)/.*\.(ex|heex)$"E
    ]
  ]

config :codebridge, dev_routes: true

config :logger, :default_formatter, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  debug_attributes: true,
  enable_expensive_runtime_checks: true

config :swoosh, :api_client, false

config :phoenix_live_view, :colocated_js,
  disable_symlink_warning: true
