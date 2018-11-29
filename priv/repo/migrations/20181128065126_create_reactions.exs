defmodule LFA.Repo.Migrations.CreateReactions do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :message_id, references(:messages, on_delete: :nothing)
      add :rating, :integer

      timestamps()
    end

    create index(:reactions, [:user_id])
    create index(:reactions, [:message_id])
    create unique_index(:reactions, [:user_id, :message_id])
  end
end
