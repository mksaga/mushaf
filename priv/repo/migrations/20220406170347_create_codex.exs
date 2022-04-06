defmodule Mushaf.Repo.Migrations.CreateCodex do
  use Ecto.Migration
  use Ecto.Schema

  def change do
    create table(:codices) do
      add :script, :string, values: [:uthmani, :urdu]
      add :line_count, :string, values: [:fifteen, :thirteen]
      add :user_id, references(:users)
    end
  end
end
