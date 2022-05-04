defmodule Mushaf.Repo.Migrations.AddCodexObserver do
  use Ecto.Migration

  def change do
    create table(:codex_observer, primary_key: false) do
      add :codex_id, references(:codices), primary_key: true
      add :observer_id, references(:users), primary_key: true
    end
  end
end
