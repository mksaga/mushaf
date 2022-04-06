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
    |> cast(attrs, [:script])
  end
end
