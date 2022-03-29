defmodule MushafWeb.TextController do
  use MushafWeb, :controller
  alias Mushaf.Text

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show_surah_ayah(conn, _params) do
    render(conn, "index.html")
  end

  def show_surah(conn, _params) do
    render(conn, "index.html")
  end

  def show_page(conn, %{"page_no" => page_no}) do
    {page_no_int, _} = Integer.parse(page_no)
    ayahs = Text.get_page_ayahs(page_no_int)
    # conn
    # |> assign(:page_no, page_no_int)
    # |> assign(:ayahs, ayahs)
    # |> render(conn, "index.html")
    render(conn, "index.html", page_no: page_no_int, ayahs: ayahs)
    # render(conn, "index.html")
  end

  def show(conn, %{"page_no" => page_no, "surah_no" => surah_no, "ayah_no" => ayah_no}) do
    render(conn, "index.html", page_no: page_no, surah_no: surah_no, ayah_no: ayah_no)
  end

end
