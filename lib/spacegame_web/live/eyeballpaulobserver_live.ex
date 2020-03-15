defmodule SpacegameWeb.EyeballpaulobserverLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(SpacegameWeb.PageView, "eyeballpaulobserver.html", assigns)
  end

  def mount(_params, _, socket) do
    # if connected?(socket), do: Phoenix.PubSub.subscribe(Spacegame.PubSub, "Eyeballpaul")

    socket
    |> assign(:team, 0)
    |> assign(:test, 13)
    |> tuplify(:ok)
  end

  # def handle_event("validate", %{"controller" => %{"deg" => deg}}, socket) do
  #   IO.inspect(deg)

  #   Phoenix.PubSub.broadcast(
  #     Spacegame.PubSub,
  #     "Eyeballpaul",
  #     {:set_deg, deg: deg}
  #   )

  #   socket
  #   |> tuplify(:noreply)
  # end

  # def handle_info(:tick, socket) do
  #   socket
  #   |> tuplify(:noreply)
  # end

  defp tuplify(value, atom), do: {atom, value}
end
