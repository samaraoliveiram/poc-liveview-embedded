defmodule CashierLiveWeb.Router do
  use CashierLiveWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {CashierLiveWeb.Layouts, :root})
    plug(:protect_from_forgery)
  end

  pipeline :external do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:protect_from_forgery, allow_hosts: ["http://localhost:3000"])
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CashierLiveWeb do
    pipe_through(:external)

    live_session :external do
      live("/cashier", CashierLive, :index)
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", CashierLiveWeb do
    pipe_through(:api)

    get("/token", PageController, :token)
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:cashier_live, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: CashierLiveWeb.Telemetry)
    end
  end
end
