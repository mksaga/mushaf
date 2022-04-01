defmodule MushafWeb.TextController do
  use MushafWeb, :controller
  require Integer

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
    )
  end

  def show(conn, %{"page_no" => page_no, "surah_no" => surah_no, "ayah_no" => ayah_no}) do
    render(conn, "index.html", page_no: page_no, surah_no: surah_no, ayah_no: ayah_no)
  end

end
