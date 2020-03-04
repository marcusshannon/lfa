defmodule LFA.Slack do
  import Ecto.Query, warn: false
  alias LFA.Repo
  alias Ecto.Multi
  alias LFA.Messages.Message
  alias LFA.Messages
  alias LFA.Reactions.Reaction
  alias LFA.SlackAPI

  def update_reactions(ts) do
    with bot_message <- Messages.get_message_by_ts(ts) do
      %{"message" => message} = SlackAPI.fetch_reactions(ts)
      reactions = transform_reactions(message["reactions"], bot_message)

      Repo.transaction(fn ->
        Repo.delete_all(from(r in Reaction, where: r.message_id == ^bot_message.id))
        Enum.each(reactions, fn reaction -> Repo.insert(reaction) end)
      end)
    end
  end

  def name_to_integer(name) do
    case name do
      "zero" -> 0
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
      "keycap_ten" -> 10
      _ -> nil
    end
  end

  def transform_reactions(reactions, _message) when is_nil(reactions) do
    []
  end

  def transform_reactions(reactions, message) do
    Enum.filter(reactions, fn reaction -> not is_nil(name_to_integer(reaction["name"])) end)
    |> Enum.reduce([], fn reaction, acc ->
      [
        Enum.map(reaction["users"], fn slack_id ->
          user = LFA.Users.get_user_by_slack_id(slack_id)

          %Reaction{
            user_id: user.id,
            message_id: message.id,
            rating: name_to_integer(reaction["name"])
          }
        end)
        | acc
      ]
    end)
    |> List.flatten()
    |> Enum.uniq_by(fn %{:user_id => user_id} -> user_id end)
  end
end
