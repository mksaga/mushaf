defmodule Mushaf.Annotation do
  alias Mushaf.Repo
  alias Mushaf.Mistake
  alias Mushaf.Accounts

  def create_mistake(%Accounts.User{} = user, attrs \\ %{}) do
    %Mistake{}
    |> Mistake.mark_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:reader, user)
    |> Repo.insert()
  end
end
