defmodule Mushaf.Mistake do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mushaf.Text

  schema "mistakes" do
    field :surah_no, :integer
    field :ayah_no, :integer
    field :start_index, :integer
    field :end_index, :integer
    field :type, Ecto.Enum, values: [:tajweed, :memorization]

    belongs_to :reader, Mushaf.Accounts.User

    timestamps()
  end

  def mark_changeset(mistake, attrs) do
    mistake
    |> cast(attrs, [:surah_no, :ayah_no, :start_index, :end_index, :type])
    |> validate_start_index()
    |> validate_end_index()
  end

  defp validate_start_index(changeset) do
    surah_no = fetch_change(changeset, :surah_no)
    ayah_no = fetch_change(changeset, :ayah_no)
    start_index = fetch_change(changeset, :start_index)
    ayah_text = Text.get_ayah(surah_no, ayah_no)
    if ayah_text != nil do
      if String.at(ayah_text, start_index) != nil do
        # all good!
        changeset
      else
        add_error(changeset, :start_index, "Start index out of bounds.")
      end
    else
      add_error(changeset, :ayah_no, "Ayah index out of bounds.")
    end
  end

  defp validate_end_index(changeset) do
    surah_no = fetch_change(changeset, :surah_no)
    ayah_no = fetch_change(changeset, :ayah_no)
    end_index = fetch_change(changeset, :end_index)
    ayah_text = Text.get_ayah(surah_no, ayah_no)
    if ayah_text != nil do
      if String.at(ayah_text, end_index) != nil do
        # all good!
        changeset
      else
        add_error(changeset, :end_index, "End index out of bounds.")
      end
    else
      add_error(changeset, :ayah_no, "Ayah index out of bounds.")
    end
  end
end
