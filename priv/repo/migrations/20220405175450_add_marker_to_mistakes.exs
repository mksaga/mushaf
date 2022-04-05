defmodule Mushaf.Repo.Migrations.AddMarkerToMistakes do
  use Ecto.Migration

  def change do
    alter table(:mistakes) do
      add :marker_id, references(:users)
    end
  end
end
