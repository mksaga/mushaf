defmodule Mushaf.Repo.Migrations.AddMostRecentPageToCodex do
  use Ecto.Migration

  def change do
    alter table(:codices) do
      add :most_recent_page, :integer, default: 1
    end
  end
end
