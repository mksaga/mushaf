defmodule MushafWeb.CodexController do
  use MushafWeb, :controller
  alias Mushaf.Codices

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def create(conn, %{"codex" => codex_params}, current_user) do
    case Codices.create_codex(current_user, codex_params) do
      {:ok, codex} ->
        conn
        |> put_flash(:info, "Your new Mushaf is ready to go!")
        # TODO: redirect here to page 1 of that mushaf
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Couldn't create your Mushaf, try again?")
    end
  end
end
