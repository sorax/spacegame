defmodule SpacegameWeb.EyeBallPaulControllerLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  def mount(_session, socket) do
    socket =
      socket
      |> assign(%{team_id: 1})
      |> assign(%{deg: 180})

    {:ok, socket}
  end

  def render(assigns) do
    PageView.render("eyeballpaulcontroller.html", assigns)
  end

  def handle_event("setDeg", %{"value" => value}, socket) do
    {:noreply, assign(socket, deg: value |> String.to_integer())}
  end
end
