defmodule MushafWeb.MistakeController do
  use MushafWeb, :controller
  alias Mushaf.Annotation

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def create(conn, %{"mistake" => mistake_params}, current_user) do
    case Annotation.create_mistake(current_user, mistake_params) do
      {:ok, mistake} ->
        conn
        |> put_flash(:info, "Mistake marked!")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Couldn't mark mistake.")
    end
  end
end
