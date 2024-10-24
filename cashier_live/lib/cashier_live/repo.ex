defmodule CashierLive.Repo do
  use Ecto.Repo,
    otp_app: :cashier_live,
    adapter: Ecto.Adapters.Postgres
end
