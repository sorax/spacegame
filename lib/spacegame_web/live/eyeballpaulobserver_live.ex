defmodule SpacegameWeb.EyeballpaulobserverLive do
  use Phoenix.LiveView

  alias SpacegameWeb.Counter

  def render(assigns) do
    Phoenix.View.render(SpacegameWeb.PageView, "eyeballpaulobserver.html", assigns)
  end

  def mount(_params, _, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Spacegame.PubSub, "Eyeballpaul")

    Counter.start_link(0)

    # => {:ok, #PID<0.123.0>}

    Counter.value()

    # => 0

    Counter.increment()

    # => :ok

    Counter.increment()

    # => :ok

    Counter.value() |> IO.inspect()

    socket
    |> assign(:ball, %{x: 0, y: 0})
    |> assign(:paddles, [])
    # |> assign(:paddles, [get_paddle(180, 20, 1)])
    |> tuplify(:ok)
  end

  def handle_info({:set_deg, %{deg: deg, id: _id}}, socket) do
    socket
    |> assign(:paddles, [get_paddle(deg, 20, 1)])
    |> tuplify(:noreply)
  end

  defp get_paddle(deg, width, player) do
    %{
      d: describe_arc(0, 0, 50, deg - width / 2, deg + width / 2),
      color: if(player == 1, do: "255,66,0", else: "0,176,111")
    }
  end

  defp describe_arc(x, y, radius, start_angle, end_angle) do
    start_value = polar_to_cartesian(x, y, radius, end_angle)
    end_value = polar_to_cartesian(x, y, radius, start_angle)

    large_arc_flag = if end_angle - start_angle <= 180, do: 0, else: 1

    [
      "M",
      start_value.x,
      start_value.y,
      "A",
      radius,
      radius,
      0,
      large_arc_flag,
      0,
      end_value.x,
      end_value.y
    ]
    |> Enum.join(" ")
  end

  defp polar_to_cartesian(center_x, center_y, radius, angle_in_degrees) do
    angle_in_radians = (angle_in_degrees - 90) * :math.pi() / 180.0

    %{
      x: round(center_x + radius * :math.cos(angle_in_radians)),
      y: round(center_y + radius * :math.sin(angle_in_radians))
    }
  end

  defp tuplify(value, atom), do: {atom, value}
end
