defmodule HelloPhxBulmaWeb.PageController do
  use HelloPhxBulmaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
