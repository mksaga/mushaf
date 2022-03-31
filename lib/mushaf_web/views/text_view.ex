defmodule MushafWeb.TextView do
  use MushafWeb, :view

  def get_ayah_id(ayah) do
    surah_no = elem(ayah, 0)
    ayah_no = elem(ayah, 1)
    "#{surah_no}-#{ayah_no}"
  end

  def get_ayah_text(ayah) do
    elem(ayah, 2)
  end

  def get_prev_page_no(page_no) do
    max(1, page_no - 1)
  end

  def get_next_page_no(page_no) do
    min(604, page_no + 1)
  end
end
