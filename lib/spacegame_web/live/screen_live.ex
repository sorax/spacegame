defmodule SpacegameWeb.ScreenLive do
  use SpacegameWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, ball: %{x: 0, y: 0}, paddles: [])}
  end
end
