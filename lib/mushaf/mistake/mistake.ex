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

    # p128 in Pragmatic Phoenix: how to associate mistake to user
    belongs_to :reader, Mushaf.Accounts.User
    belongs_to :marker, Mushaf.Accounts.User

    timestamps()
  end

  def mark_changeset(mistake, attrs) do
    mistake
    |> cast(attrs, [:surah_no, :ayah_no, :start_index, :end_index, :type])
    |> validate_start_index()
    |> validate_end_index()
  end

  defp validate_start_index(changeset) do
    surah_no = get_field(changeset, :surah_no)
    ayah_no = get_field(changeset, :ayah_no)
    start_index = get_field(changeset, :start_index)
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
    surah_no = get_field(changeset, :surah_no)
    ayah_no = get_field(changeset, :ayah_no)
    end_index = get_field(changeset, :end_index)
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
