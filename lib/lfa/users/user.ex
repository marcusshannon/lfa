defmodule LFA.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :slack_id, :string
    has_many :reactions, LFA.Reactions.Reaction

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> change(attrs)
    |> validate_required([:slack_id, :name])
  end
end
