defmodule Codebridge.Repo do
  use Ecto.Repo,
    otp_app: :codebridge,
    adapter: Ecto.Adapters.Postgres
end
