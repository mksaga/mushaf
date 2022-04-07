defmodule Mushaf.CodexPermission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "codex_permissions" do
    belongs_to :codex, Mushaf.Codex
    belongs_to :user, Mushaf.Accounts.User
    field :permission, Ecto.Enum, values: [:view, :mark]
  end

  def create_changeset(codex_permission, attrs) do
    codex_permission
    |> cast(attrs, [:codex, :user, :permission])
  end
end
