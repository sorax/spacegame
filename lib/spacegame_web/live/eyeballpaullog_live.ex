defmodule SpacegameWeb.EyeballpaullogLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(SpacegameWeb.PageView, "eyeballpaullog.html", assigns)
  end

  def mount(_params, _, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Spacegame.PubSub, "Eyeballpaul")

    socket
    |> assign(:log, "")
    |> tuplify(:ok)
  end

  def handle_info({:set_deg, %{deg: deg, id: id}}, socket) do
    deg_string = deg |> Integer.to_string()

    socket
    |> assign(:log, "#{id}: #{deg_string}")
    |> tuplify(:noreply)
  end

  defp tuplify(value, atom), do: {atom, value}
end
