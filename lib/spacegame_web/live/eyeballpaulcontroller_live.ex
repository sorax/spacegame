defmodule SpacegameWeb.EyeBallPaulControllerLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  alias Spacegame.Chat

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

  def handle_event("set_deg", %{"controller" => %{"deg" => deg}}, socket) do
    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "Spacegame.Chat",
      {Spacegame.Chat, :set_deg, %{player: 1, deg: deg}}
    )

    {:noreply, socket}
  end
end
