defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    messages = LFA.Messages.list_messages()
    IO.inspect(messages)

    render(conn, "index.html", messages: messages)
  end
end
