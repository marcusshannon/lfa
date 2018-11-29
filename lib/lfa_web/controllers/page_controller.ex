defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    reactions = LFA.Messages.list_messages
    IO.inspect(reactions)

    render(conn, "index.html")
  end
end
