defmodule SpacegameWeb.Router do
  use SpacegameWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpacegameWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/eyeballpaul", PageController, :eyeballpaul

    live "/eyeballpaul/controller", EyeballpaulcontrollerLive
    live "/eyeballpaul/observer", EyeballpaulobserverLive
    live "/eyeballpaul/log", EyeballpaullogLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpacegameWeb do
  #   pipe_through :api
  # end
end
