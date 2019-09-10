defmodule LFA.Reactions do
  import Ecto.Query, warn: false
  alias LFA.Repo

  alias LFA.Reactions.Reaction
  alias LFA.Messages.Message

  def list_reactions do
    Repo.all(Reaction)
  end

  def get_reaction!(id), do: Repo.get!(Reaction, id)

  def create_reaction(attrs \\ %{}) do
    %Reaction{}
    |> Reaction.changeset(attrs)
    |> Repo.insert()
  end

  def update_reaction(%Reaction{} = reaction, attrs) do
    reaction
    |> Reaction.changeset(attrs)
    |> Repo.update()
  end

  def delete_reaction(%Reaction{} = reaction) do
    Repo.delete(reaction)
  end

  def change_reaction(%Reaction{} = reaction) do
    Reaction.changeset(reaction, %{})
  end
end
