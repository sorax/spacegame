defmodule SpacegameWeb.EyeballpaulcontrollerLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(SpacegameWeb.PageView, "eyeballpaulcontroller.html", assigns)
  end

  def mount(_params, _, socket) do
    # if connected?(socket), do: Phoenix.PubSub.subscribe(Spacegame.PubSub, "Eyeballpaul")
    # if connected?(socket), do: :timer.send_interval(30000, self(), :update)

    socket
    |> assign(:team, 0)
    |> tuplify(:ok)
  end

  # def handle_event("set_deg", %{"controller" => %{"deg" => deg}}, socket) do
  #   # IO.inspect(socket.id)

  #   Phoenix.PubSub.broadcast(Spacegame.PubSub, "Eyeballpaul", {:set_deg, %{deg: deg}})

  #   socket
  #   |> tuplify(:noreply)
  # end

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
