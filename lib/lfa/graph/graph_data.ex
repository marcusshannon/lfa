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

  defp check_next_date([first | _] = date_list) do
    if Date.diff(Date.utc_today(), first) < 2 do
      check_next_date(date_list, 1)
    else
      0
    end
  end

  defp check_next_date(_) do
    0
  end

  defp check_next_date([first, second | tail], acc) do
    if Date.diff(first, second) == 1 do
      check_next_date([second | tail], acc + 1)
    else
      acc
    end
  end

  defp check_next_date(_, acc) do
    acc
  end

  def get_streak_by_user(user_id) do
    date_list =
      Repo.all(
        from r in Reaction,
          join: m in assoc(r, :message),
          where: r.user_id == ^user_id,
          order_by: [desc: m.ts],
          select: m.ts
      )
      |> Enum.map(fn ts ->
        {unix, _} = Integer.parse(ts)

        DateTime.from_unix!(unix)
        |> DateTime.to_date()
      end)

    check_next_date(date_list)
  end

  def get_user_average(user_id) do
    Repo.all(
      from r in Reaction,
        join: m in assoc(r, :message),
        where: r.user_id == ^user_id,
        select: avg(r.rating)
    )
  end
end
