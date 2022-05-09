defmodule MushafWeb.CodexObserverController do
  use MushafWeb, :controller
  alias Mushaf.{Codex, CodexObserver, Codices, Repo, Text}
  alias Mushaf.Accounts

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, %{"codex_observer" => codex_observer_params}, _user) do
    {observer_username} = codex_observer_params
    observer = Accounts.get_user_by_username(observer_username)
    codex = Codices.get_codex!(conn.assigns.codex_id)
    co = %CodexObserver{codex: codex, observer: observer}
    changeset = CodexObserver.link_observer(codex, observer)
  end

  def delete(conn, current_user) do

  end

end
