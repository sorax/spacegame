defmodule SpacegameWeb.EyeBallPaulControllerLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  alias Spacegame.Chat
  alias Phoenix.PubSub

  def mount(_session, socket) do
    if connected?(socket), do: PubSub.subscribe(Spacegame.PubSub, "EyeBallPaulController")

    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "EyeBallPaulObserver",
      {:connecting, id: socket.id}
    )

    socket =
      socket
      |> assign(%{team: 0})

    {:ok, socket}
  end

  def render(assigns) do
    PageView.render("eyeballpaulcontroller.html", assigns)
  end

  def handle_event("set_deg", %{"controller" => %{"deg" => deg}}, socket) do
    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "EyeBallPaulObserver",
      {:set_deg, deg: deg}
    )

    {:noreply, socket}
  end

  def handle_info({:connected, id: id, team: team}, socket) do
    socket = if id == socket.id, do: assign(socket, %{team: team}), else: socket
    {:noreply, socket}
  end
end
