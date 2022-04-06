defmodule Mushaf.Codices do

  import Ecto.Query
  alias Mushaf.Repo
  alias Mushaf.Codex
  alias Mushaf.Accounts

  def get_codices_by_user(user) do
    Repo.get_by(Codex, user: user)
  end

  def create_codex(%Accounts.User{} = user, attrs) do
    %Codex{}
    |> Codex.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end
end
