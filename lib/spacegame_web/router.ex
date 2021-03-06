defmodule SpacegameWeb.Router do
  use SpacegameWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SpacegameWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpacegameWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/eyeballpaul", SpacegameWeb do
    pipe_through :browser

    live "/controller", Eyeballpaul.ControllerLive, :index,
      layout: {SpacegameWeb.Eyeballpaul.LayoutView, "live.html"}

    live "/screen", Eyeballpaul.ScreenLive, :index
    # layout: {SpacegameWeb.Eyeballpaul.LayoutView, :root}
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpacegameWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SpacegameWeb.Telemetry
    end
  end
end
