defmodule Mushaf.Repo.Migrations.AddNanoIdToUserMushaf do
  use Ecto.Migration

  def change do
    alter table(:codices) do
      add :nano_id, :string
    end

    alter table(:users) do
      add :nano_id, :string
    end
  end
end
