defmodule Mushaf.Repo.Migrations.CreateCodexUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:codices, [:nano_id])
  end
end
