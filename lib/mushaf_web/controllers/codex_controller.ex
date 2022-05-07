defmodule MushafWeb.CodexController do
  use MushafWeb, :controller
  require Integer
  alias Mushaf.Codex
  alias Mushaf.Codices
  alias Mushaf.Text

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, _params, _user) do
    changeset = Codices.change_codex_changeset(%Codex{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"codex" => codex_params}, current_user) do
    case Codices.create_codex(current_user, codex_params) do
      {:ok, codex} ->
        conn
        |> put_flash(:info, "Your new Mushaf is ready to go!")
        |> redirect(to: Routes.codex_path(conn, :show_page, codex.nano_id, 1))
      {:error, _} ->
        conn
        |> put_flash(:error, "Couldn't create your Mushaf, try again?")
    end
  end

  def settings(conn, %{"mushaf_id" => codex_id}, current_user) do
    result = Codices.get_user_codex(codex_id, current_user)
    case result do
      nil ->
        conn
        |> put_flash(:error, "That Mushaf does not exist!")
        |> redirect(to: Routes.page_path(conn, :index))
      codex ->
        # Retrieve other users who have permission
        query = from co in CodexObserver, select: co, where: co.codex_id == ^codex.id
        codex_observers = Repo.all(query)
        shared_with = Enum.map(
          codex_observers,
          fn codex_observer ->
            Repo.preload(codex_observer, :observer).observer
          end)


        mushaf_name: codex.name
        render(
          conn,
          "settings.html",
          mushaf_name: mushaf_name,
          shared_with: shared_with
        )
    end
  end

  def show_page(conn, %{"mushaf_id" => codex_id, "page_no" => page_no}, current_user) do
    result = Codices.get_user_codex(codex_id, current_user)

    case result do
      nil ->
        conn
        |> put_flash(:error, "That Mushaf does not exist!")
        |> redirect(to: Routes.page_path(conn, :index))
      codex ->
        {page_no_int, _} = Integer.parse(page_no)
        {ayahs_right, ayahs_left} = Text.get_spread_ayahs(page_no_int)

        {page_right, page_left} =
          if Integer.is_even(page_no_int) do
            {page_no_int - 1, page_no_int}
          else
            {page_no_int, page_no_int + 1}
          end

        render(
          conn,
          "index.html",
          page_no: page_no_int,
          page_right: page_right,
          page_left: page_left,
          ayahs_left: ayahs_left,
          ayahs_right: ayahs_right,
          mushaf_id: codex_id,
          mushaf_name: codex.name,
        )
    end
  end
end
