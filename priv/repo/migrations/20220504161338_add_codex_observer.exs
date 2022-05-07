defmodule Mushaf.Repo.Migrations.AddCodexObserver do
  use Ecto.Migration

  def change do
    create table(:codex_observer) do
      add :codex_id, references(:codices), primary_key: true
      add :observer_id, references(:users), primary_key: true
    end

    create unique_index(:codex_observer, [:codex_id, :observer_id])
  end
end
