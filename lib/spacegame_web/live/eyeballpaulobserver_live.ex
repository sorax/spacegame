defmodule SpacegameWeb.EyeBallPaulObserverLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  alias Spacegame.Chat
  alias Phoenix.PubSub

  def mount(_session, socket) do
    if connected?(socket), do: PubSub.subscribe(Spacegame.PubSub, "EyeBallPaulObserver")

    socket =
      socket
      |> assign(%{
        ball: %{x: 0, y: 0},
        paddles: []
      })

    # Counter.start_link(0)
    # # => {:ok, #PID<0.123.0>}

    # Counter.value()
    # # => 0

    # Counter.increment()
    # # => :ok

    # Counter.increment()
    # # => :ok

    # Counter.value()

    :timer.apply_interval(1000, SpacegameWeb.EyeBallPaulObserverLive, :set_ball_pos, [
      socket
    ])

    {:ok, socket}
  end

  def render(assigns) do
    # ~L"Rendering LiveView"

    PageView.render("eyeballpaulobserver.html", assigns)
  end

  def handle_info({:connecting, id: id}, socket) do
    _players = %{}
    _teams = %{1 => [], 2 => []}
    _size = 20

    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "EyeBallPaulController",
      {:connected, id: id, team: 1}
    )

    {:noreply, socket}
  end

  def handle_info({:set_deg, deg: deg}, socket) do
    IO.inspect(socket.id <> ": " <> deg)

    socket =
      socket
      |> assign(paddles: [get_paddle(deg, 20, 1)])

    {:noreply, socket}
  end

  def set_ball_pos(socket) do
    # %{
    #   x: socket.assigns.ball.x + 10,
    #   y: socket.assigns.ball.y
    # }

    socket =
      socket
      |> assign(%{
        ball: %{
          x: socket.assigns.ball.x + 10,
          y: socket.assigns.ball.y
        }
      })

    {:noreply, socket}
  end

  def get_paddle(deg, width, player) do
    %{
      d: describe_arc(0, 0, 50, deg - width / 2, deg + width / 2),
      color: if(player == 1, do: "255,66,0", else: "0,176,111")
    }
  end

  def describe_arc(x, y, radius, start_angle, end_angle) do
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

  def polar_to_cartesian(center_x, center_y, radius, angle_in_degrees) do
    angle_in_radians = (angle_in_degrees - 90) * :math.pi() / 180.0

    %{
      x: round(center_x + radius * :math.cos(angle_in_radians)),
      y: round(center_y + radius * :math.sin(angle_in_radians))
    }
  end
end
