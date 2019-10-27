defmodule SpacegameWeb.PageController do
  use SpacegameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def eyeballpaul(conn, _params) do
    render(conn, "eyeballpaul.html")
  end
end
