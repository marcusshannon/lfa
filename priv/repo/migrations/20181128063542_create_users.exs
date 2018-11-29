defmodule LFA.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :slack_id, :string
      add :name, :string

      timestamps()
    end
  end
end
