defmodule SpacegameWeb.EyeballpaulcontrollerLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(SpacegameWeb.PageView, "eyeballpaulcontroller.html", assigns)
  end

  def mount(_params, _, socket) do
    # if connected?(socket), do: Phoenix.PubSub.subscribe(Spacegame.PubSub, "Eyeballpaul")
    # if connected?(socket), do: :timer.send_interval(30000, self(), :update)

    socket
    |> assign(:id, socket.id)
    |> assign(:team, 0)
    |> tuplify(:ok)
  end

  def handle_event("set_deg", %{"controller" => %{"deg" => deg}}, socket) do
    # IO.inspect(socket.id)
    # IO.inspect(deg)

    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "Eyeballpaul",
      {:set_deg, %{deg: String.to_integer(deg), id: socket.id}}
    )

    socket
    |> tuplify(:noreply)
  end

  # def handle_info(:tick, socket) do
  #   socket
  #   |> tuplify(:noreply)
  # end

  # def handle_info(:update, socket) do
  #   socket
  #   |> assign(:temperature, 15)
  #   |> tuplify(:noreply)
  # end

  defp tuplify(value, atom), do: {atom, value}
end
