defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    messages = LFA.Messages.list_messages()

    data =
      LFA.GraphData.get_past_month_data()
      |> Jason.encode!()

    render(conn, "index.html", messages: messages, data: data)
  end

  def user(conn, %{"user_name" => user_name}) do
    user = LFA.Users.get_user_by_name!(user_name)

    data =
      LFA.GraphData.get_data_by_user(user.id, user.name)
      |> Jason.encode!()

    render(conn, "user.html", name: user.name, data: data)
  end

  def shell(conn, %{"year" => year, "month" => month}) do
    messages = LFA.Messages.list_messages()

    data =
      LFA.GraphData.get_past_month_data()
      |> Jason.encode!()

    render(conn, "shell.html", messages: messages, data: data)
  end

  def shell(conn, _) do
    messages = LFA.Messages.list_messages()

    data =
      LFA.GraphData.get_past_month_data()
      |> Jason.encode!()

    render(conn, "shell.html", messages: messages, data: data)
  end
end
