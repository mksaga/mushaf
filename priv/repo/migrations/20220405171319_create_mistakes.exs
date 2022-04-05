defmodule Mushaf.Repo.Migrations.CreateMistakes do
  use Ecto.Migration
  use Ecto.Schema

  def change do
    create table(:mistakes) do
      add :surah_no, :integer
      add :ayah_no, :integer
      add :start_index, :integer
      add :end_index, :integer
      add :type, :string, values: [:tajweed, :memorization]
      timestamps()
      end
  end
end
