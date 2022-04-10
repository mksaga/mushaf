defmodule Mushaf.Repo.Migrations.AddTimestampsToCodex do
  use Ecto.Migration

  def change do
    alter table(:codices) do
      timestamps()
    end
  end
end
