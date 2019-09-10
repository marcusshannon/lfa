defmodule LFA.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :ts, :string
    has_many :reactions, LFA.Reactions.Reaction

    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, [:ts])
    |> validate_required([:ts])
  end
end
