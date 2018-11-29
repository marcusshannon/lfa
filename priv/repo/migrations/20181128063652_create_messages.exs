defmodule LFA.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :ts, :string

      timestamps()
    end

  end
end
