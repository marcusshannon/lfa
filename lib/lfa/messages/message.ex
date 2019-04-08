defmodule LFA.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :ts]}
  schema "messages" do
    field :ts, :string
    has_many :reactions, LFA.Reactions.Reaction

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:ts])
    |> validate_required([:ts])
  end
end
