defmodule HelloPhxBulma.Repo do
  use Ecto.Repo,
    otp_app: :hello_phx_bulma,
    adapter: Ecto.Adapters.Postgres
end
