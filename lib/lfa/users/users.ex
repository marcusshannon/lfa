defmodule LFA.Users do
  import Ecto.Query, warn: false
  alias LFA.Repo

  alias LFA.Users.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_name!(name) do
    Repo.one(from u in User, where: fragment("lower(?)", u.name) == ^name)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_slack_id(slack_id) do
    Repo.get_by!(User, slack_id: slack_id)
  end

  def ts_to_date(ts) do
    {unix, _} = Integer.parse(ts)

    DateTime.from_unix!(unix)
    |> DateTime.to_date()
    |> Date.to_string()
  end

  def get_chart_data() do
    Repo.all(User)
    |> Repo.preload(reactions: [:message])
    |> Enum.map(fn user ->
      reactions =
        Enum.reduce(user.reactions, %{}, fn reaction, acc ->
          Map.put(acc, ts_to_date(reaction.message.ts), reaction.rating)
        end)

      %{name: user.name, data: reactions}
    end)
  end
end
