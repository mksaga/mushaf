defmodule Mushaf.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mushaf.Accounts.User

  schema "permissions" do

    belongs_to :user, Accounts.User
    belongs_to :accessor, Accounts.User
    field :access_type, Ecto.Enum, values: [:view, :mark]

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [])
    |> validate_required([])
  end
end
