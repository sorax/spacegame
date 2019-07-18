defmodule SpacegameWeb.PageController do
  use SpacegameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
