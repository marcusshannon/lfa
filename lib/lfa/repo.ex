defmodule LFA.Repo do
  use Ecto.Repo,
    otp_app: :lfa,
    adapter: Ecto.Adapters.Postgres
end
