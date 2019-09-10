defmodule LFA.Messages do
  import Ecto.Query, warn: false
  alias LFA.Repo

  alias LFA.Messages.Message

  def month_messages do
    month_seconds = "#{System.system_time(:second) - 2_592_000}"
    Repo.all(from m in Message, where: m.ts > ^month_seconds, order_by: [asc: m.ts])
  end

  def list_messages do
    reactions_query = from r in LFA.Reactions.Reaction, order_by: r.user_id, preload: [:user]

    messages =
      Repo.all(from m in Message, order_by: [desc: m.ts], preload: [reactions: ^reactions_query])

    Enum.map(messages, fn message ->
      reactions =
        Enum.reduce(message.reactions, %{}, fn reaction, acc ->
          Map.put(acc, reaction.user.name, reaction.rating)
        end)

      %{ts: message.ts, reactions: reactions}
    end)
  end

  def get_message!(id), do: Repo.get!(Message, id)

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  def change_message(%Message{} = message) do
    Message.changeset(message, %{})
  end

  def get_message_by_ts(ts) do
    Repo.get_by(Message, ts: ts)
  end
end
