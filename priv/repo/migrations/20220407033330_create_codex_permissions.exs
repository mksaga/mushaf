defmodule Mushaf.Repo.Migrations.CreateCodexPermissions do
  use Ecto.Migration

  def change do
    create table(:codex_permissions, primary_key: false) do
      add :codex, references(:codices)
      add :user, references(:users)
      add :permission, :string, values: [:view, :mark]
    end
  end
end
