defmodule Mushaf.Codices do

  import Ecto.Query
  alias Mushaf.Repo
  alias Mushaf.Codex
  alias Mushaf.Accounts

  def get_codices_by_user(user) do
    Repo.all(Codex, user_id: user.id, preload: [:users_with_access])
  end

  def get_codex!(id), do: Repo.get!(Codex, id)

  def create_codex(%Accounts.User{} = user, attrs) do
    %Codex{}
    |> Codex.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def grant_codex_permission(codex, user_id, permission) do
    codex
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users_with_access, [Accounts.get_user!(user_id), permission])
    |> Repo.update!()
  end
end
