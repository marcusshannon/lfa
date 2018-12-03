defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    messages = LFA.Messages.list_messages()
    IO.inspect(messages)

    data =
      LFA.Users.get_chart_data()
      |> Enum.filter(fn x -> not Enum.empty?(x.data) end)
      |> Jason.encode!()

    render(conn, "index.html", messages: messages, data: data)
  end
end
