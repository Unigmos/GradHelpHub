defmodule GradHelpHubWebWeb.TeapotController do
  use GradHelpHubWebWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(418)
    |> json(%{message: "I'm a teapot"})
  end
end
