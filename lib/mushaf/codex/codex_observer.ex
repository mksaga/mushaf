defmodule Mushaf.CodexObserver do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mushaf.Repo
  alias Mushaf.Codex
  alias Mushaf.Accounts

  schema "codex_observer" do
    belongs_to :codex, Mushaf.Codex
    belongs_to :observer, Mushaf.Accounts.User
  end

  def link_observer(
    codex_observer,
    %Mushaf.Codex{} = codex,
    %Mushaf.Accounts.User{} = observer
  ) do
    codex_observer
    |> change()
    |> put_assoc(:codex, codex)
    |> put_assoc(:observer, observer)
    |> Repo.insert()
  end

end
