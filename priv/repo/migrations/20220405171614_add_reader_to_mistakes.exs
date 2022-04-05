defmodule Mushaf.Repo.Migrations.AddReaderToMistakes do
  use Ecto.Migration

  def change do
    alter table(:mistakes) do
      add :reader_id, references(:users)
    end
  end
end
