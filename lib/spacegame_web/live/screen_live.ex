defmodule SpacegameWeb.ScreenLive do
  use SpacegameWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    qr =
      (SpacegameWeb.Endpoint.url() <> Routes.controller_path(socket, :index))
      |> EQRCode.encode()
      |> EQRCode.svg()

    {:ok, assign(socket, ball: %{x: 0, y: 0}, paddles: [], qr: qr)}
  end
end
