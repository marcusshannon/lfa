defmodule LFA.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias LFA.Repo

  alias LFA.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def users_map do
    list_users
    |> LFA.Utils.list_to_map()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
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
