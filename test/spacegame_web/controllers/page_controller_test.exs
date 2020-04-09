defmodule SpacegameWeb.PageControllerTest do
  use SpacegameWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Spacegame"
  end
end
