defmodule Mushaf.Codex do
  use Ecto.Schema
  import Ecto.Changeset

  schema "codices" do
    field :script, Ecto.Enum, values: [:uthmani, :urdu]
    field :most_recent_page, :integer, default: 1

    belongs_to :user, Mushaf.Accounts.User
  end

  def create_changeset(codex, attrs) do
    codex
    |> cast(attrs, [:script, :most_recent_page])
    |> validate_most_recent_page(changeset)
  end

  defp validate_most_recent_page(changeset) do
    page_no = get_field(changeset, :most_recent_page)
    script = get_field(changeset, :script)
    case script do
      :uthamni ->
        if page_no > 0 and page_no < 605 do
          changeset
        else
          add_error(changeset, :most_recent_page, "Last page is invalid!")
        end
      :urdu -> changeset
    end
  end
end
