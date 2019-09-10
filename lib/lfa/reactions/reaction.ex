defmodule LFA.Reactions.Reaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reactions" do
    belongs_to :user, LFA.Users.User
    belongs_to :message, LFA.Messages.Message
    field :rating, :integer

    timestamps()
  end

  def changeset(reaction, attrs) do
    reaction
    |> change(attrs)
    |> validate_required([:user_id, :message_id])
    |> unique_constraint(:user_id, name: :reactions_user_id_message_id_index)
  end
end
