defmodule Mushaf.Repo.Migrations.AddNameToCodex do
  use Ecto.Migration

  def change do
    alter table(:codices) do
      add :name, :string, size: 80
    end
  end
end
