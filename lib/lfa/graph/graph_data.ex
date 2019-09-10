defmodule LFA.GraphData do
  import Ecto.Query, warn: false
  alias LFA.Repo
  alias LFA.Messages
  alias LFA.Reactions.Reaction

  def ts_to_date(ts) do
    {unix, _} = Integer.parse(ts)

    DateTime.from_unix!(unix)
    |> DateTime.to_date()
    |> Date.to_string()
  end

  def get_past_month_data() do
    Messages.month_messages()
    |> Repo.preload(reactions: :user)
    |> Enum.flat_map(fn message ->
      Enum.map(message.reactions, fn reaction ->
        %{rating: reaction.rating, name: reaction.user.name, date: ts_to_date(message.ts)}
      end)
    end)
    |> Enum.group_by(fn reaction -> reaction.name end)
    |> Enum.reduce([], fn {name, data}, acc ->
      [
        %{
          name: name,
          data:
            Enum.reduce(data, %{}, fn x, acc ->
              Map.put(acc, x.date, x.rating)
            end)
        }
        | acc
      ]
    end)
  end

  def get_data_by_user(user_id, name) do
    data =
      Repo.all(
        from r in Reaction,
          where: r.user_id == ^user_id,
          preload: :message
      )
      |> Enum.reduce(%{}, fn x, acc ->
        Map.put(acc, ts_to_date(x.message.ts), x.rating)
      end)

    [%{name: name, data: data}]
  end
end
