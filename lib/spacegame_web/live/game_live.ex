defmodule SpacegameWeb.GameLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    # ~L"Rendering LiveView"
    PageView.render("ship.html", assigns)
  end

  def handle_event("test", _value, socket) do
    IO.puts("handle_event: test")
    {:noreply, socket}
  end
end
