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

    streak = LFA.GraphData.get_streak_by_user(user.id)

    [average_decimal] = LFA.GraphData.get_user_average(user.id)



    average = case average_decimal do
      nil -> 0
      _ -> Decimal.to_float(average_decimal) |> Float.floor(4)
    end

    render(conn, "user.html", name: user.name, data: data, streak: streak, average: average)
  end
end
