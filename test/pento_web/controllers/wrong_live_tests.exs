defmodule PentoWeb.WrongLiveTest do
  use PentoWeb.ConnCase

  import Pento.AccountsFixtures

  setup do
    %{user: user_fixture()}
  end

  test "anonymous user GET / should redirect to login", %{conn: conn} do
    conn = get(conn, "/")

    assert redirected_to(conn) == "/users/log_in"
  end

  test "logged in user GET / should load", %{conn: conn, user: user} do
    conn =
      conn
      |> log_in_user(user)
      |> get("/")

    assert html_response(conn, 200) =~ "Make a guess"
  end
end
