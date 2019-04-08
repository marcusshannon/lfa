defmodule LFA.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name]}

  schema "users" do
    field :name, :string
    field :slack_id, :string
    has_many :reactions, LFA.Reactions.Reaction

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> change(attrs)
    |> cast(attrs, [:slack_id, :name])
    |> validate_number(:slack_id, less_than: 3)
    |> validate_required([:slack_id, :name])
  end
end
