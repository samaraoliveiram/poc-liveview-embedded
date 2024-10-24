defmodule CashierLiveWeb.PageController do
  use CashierLiveWeb, :controller

  def token(conn, _params) do
    IO.puts("JSON")
    json(conn, %{token: get_csrf_token()})
  end
end
