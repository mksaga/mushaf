defmodule Mushaf.Annotation do
  alias Mushaf.Repo
  alias Mushaf.Mistake

  def create_mistake(attrs \\ %{}) do
    %Mistake{}
    |> Mistake.mark_changeset(attrs)
    |> Repo.insert()
  end
end
