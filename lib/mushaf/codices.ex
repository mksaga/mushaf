defmodule Mushaf.Codices do

  import Ecto.Query
  alias Mushaf.Repo
  alias Mushaf.Codex
  alias Mushaf.Accounts

  def change_codex_changeset(%Codex{} = codex, attrs \\ %{}) do
    Codex.create_changeset(codex, attrs)
  end

  def get_codices_by_user(user) do
    Codex
    |> where([codex], codex.user_id == ^user.id)
    |> Repo.all()
  end

  def add_observer(codex, observer) do
    Codex.add_observer(codex, observer)
  end

  def get_codex!(id), do: Repo.get!(Codex, id)

  def get_user_codex(codex_nano_id, user) do
    Repo.get_by(Codex, nano_id: codex_nano_id, user_id: user.id)
  end

  def create_codex(%Accounts.User{} = user, attrs) do
    %Codex{}
    |> Codex.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end
end
