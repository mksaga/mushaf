defmodule Mushaf.CodexObserver do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mushaf.Codex

  schema "codex_observer" do
    belongs_to :codex, Mushaf.Codex
    belongs_to :observer, Mushaf.Accounts.User
  end
end
