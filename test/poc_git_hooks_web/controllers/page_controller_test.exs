defmodule PocGitHooksWeb.PageControllerTest do
  use PocGitHooksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix1!"
  end
end
