defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
