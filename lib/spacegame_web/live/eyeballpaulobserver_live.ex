defmodule SpacegameWeb.EyeBallPaulObserverLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  def mount(_session, socket) do
    socket =
      socket
      |> assign(%{
        ball: %{x: 0, y: 0},
        paddle: %{
          deg: 0,
          d: describe_arc(0, 0, 100, 0, 180)
        }
      })

    {:ok, socket}
  end

  def render(assigns) do
    # ~L"Rendering LiveView"

    PageView.render("eyeballpaulobserver.html", assigns)
  end

  defp polar_to_cartesian(center_x, center_y, radius, angle_in_degrees) do
    angle_in_radians = (angle_in_degrees - 90) * :math.pi() / 180

    %{
      x: center_x + radius * :math.cos(angle_in_degrees),
      y: center_y + radius * :math.sin(angle_in_radians)
    }
  end

  defp describe_arc(x, y, radius, start_angle, end_angle) do
    start_point = polar_to_cartesian(x, y, radius, end_angle)
    end_point = polar_to_cartesian(x, y, radius, start_angle)

    # large_arc_flag = endAngle - startAngle <= 180 ? "0" : "1"

    large_arc_flag =
      cond do
        end_angle - start_angle == 180 -> "0"
        end_angle - start_angle < 180 -> "0"
        true -> "1"
      end

    [
      "M",
      start_point.x,
      start_point.y,
      "A",
      radius,
      radius,
      0,
      large_arc_flag,
      0,
      end_point.x,
      end_point.y
    ]
    |> Enum.join(" ")
  end
end

# function polarToCartesian(centerX, centerY, radius, angleInDegrees) {
#   var angleInRadians = (angleInDegrees-90) * Math.PI / 180.0;

#   return {
#     x: centerX + (radius * Math.cos(angleInRadians)),
#     y: centerY + (radius * Math.sin(angleInRadians))
#   };
# }

# function describeArc(x, y, radius, startAngle, endAngle){

#     var start = polarToCartesian(x, y, radius, endAngle);
#     var end = polarToCartesian(x, y, radius, startAngle);

#     var largeArcFlag = endAngle - startAngle <= 180 ? "0" : "1";

#     var d = [
#         "M", start.x, start.y,
#         "A", radius, radius, 0, largeArcFlag, 0, end.x, end.y
#     ].join(" ");

#     return d;
# }

# document.getElementById("arc1").setAttribute("d", describeArc(200, 400, 100, 0, 180))
