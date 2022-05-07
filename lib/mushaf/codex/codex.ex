defmodule Mushaf.Codex do
  use Ecto.Schema
  import Ecto.Changeset
  alias Nanoid
  alias Mushaf.CodexObserver

  schema "codices" do
    field :script, Ecto.Enum, values: [:uthmani, :urdu]
    field :most_recent_page, :integer, default: 1
    field :nano_id, :string
    field :name, :string

    belongs_to :user, Mushaf.Accounts.User
    many_to_many :observers, Mushaf.Accounts.User, join_through: Mushaf.CodexObserver, join_keys: [codex_id: :id, observer_id: :id]
    timestamps()
  end

  def create_changeset(codex, attrs) do
    codex
    |> cast(attrs, [:script, :name])
    |> validate_most_recent_page()
    |> validate_required([:name])
    |> validate_length(:name, max: 80)
    |> add_nanoid()
  end

  def add_observer(codex, user) do
    %CodexObserver{}
    |> CodexObserver.link_observer(codex, user)
  end

  defp add_nanoid(changeset) do
    changeset
    |> put_change(:nano_id, Nanoid.generate())
  end

  defp validate_most_recent_page(changeset) do
    page_no = get_field(changeset, :most_recent_page)
    script = get_field(changeset, :script)
    case script do
      :uthmani ->
        if page_no > 0 and page_no < 605 do
          changeset
        else
          add_error(changeset, :most_recent_page, "Last page is invalid!")
        end
      :urdu -> changeset
      nil -> changeset
    end
  end
end
