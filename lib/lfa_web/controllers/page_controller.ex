defmodule LFAWeb.PageController do
  use LFAWeb, :controller

  def index(conn, _params) do
    messages = LFA.Messages.list_messages()

    data =
      LFA.Users.get_chart_data()
      |> Enum.filter(fn x -> not Enum.empty?(x.data) end)
      |> Jason.encode!()

    render(conn, "index.html", messages: messages, data: data)
  end

  def react(conn, _params) do
    users = LFA.Users.users_map()
    messages = LFA.Messages.messages_map()

    raw_reactions = LFA.Reactions.list_reactions()

    reactions =
      LFA.Reactions.list_reactions()
      # |> Enum.filter(fn reaction -> reaction.user_id == 2 or reaction.user_id == 6 end)
      |> Enum.sort(fn a, b -> messages[a.message_id].ts < messages[b.message_id].ts end)
      |> Enum.group_by(& &1.user_id)
      |> Enum.reduce([], fn {key, value}, acc ->
        [
          %{
            label: users[key].name,
            data: value,
            fill: false,
            borderColor: "red"
          }
          | acc
        ]
      end)
      |> Enum.map(fn dataset ->
        Map.update!(dataset, :data, fn reactions ->
          Enum.map(reactions, fn reaction ->
            %{y: reaction.rating, t: LFA.Graph.ts_to_date(messages[reaction.message_id].ts)}
          end)
        end)
      end)

    put_layout(conn, {LFAWeb.LayoutView, "react.html"})
    |> render("react.html",
      initial_state: %{
        users: users,
        reactions: reactions,
        messages: messages,
        raw_reactions: raw_reactions,
        token: get_csrf_token()
      }
    ) 
  end
end
