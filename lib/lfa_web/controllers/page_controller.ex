defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    messages = LFA.Messages.list_messages()
    data = Jason.encode!(LFA.Users.get_chart_data())

    render(conn, "index.html", messages: messages, data: data)
  end
end
