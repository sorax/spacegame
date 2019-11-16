defmodule SpacegameWeb.EyeBallPaulGameLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  def mount(_session, socket) do
    socket =
      socket
      |> assign(%{ball: %{x: 100, y: 100}})

    {:ok, socket}
  end

  def render(assigns) do
    # ~L"Rendering LiveView"

    PageView.render("eyeballpaulgame.html", assigns)
  end
end
