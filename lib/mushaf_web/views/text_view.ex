defmodule MushafWeb.TextView do
  use MushafWeb, :view
  alias Mushaf.Text

  def get_ayah_id(ayah) do
    surah_no = elem(ayah, 0)
    ayah_no = elem(ayah, 1)
    "#{surah_no}-#{ayah_no}"
  end

  def is_first_ayah(ayah) do
    elem(ayah, 1) == 1
  end

  def surah_title(ayah) do
    surah_no = elem(ayah, 0)
    "سورة " <> Text.get_surah_name(surah_no)
  end

  def surah_starts_with_basmalah(ayah) do
    surah_no = elem(ayah, 0)
    surah_no != 9 and surah_no != 1
  end

  def get_ayah_text(ayah) do
    ayah_text = elem(ayah, 2)
    ayah_number = elem(ayah, 1)
    surah_number = elem(ayah, 0)
    if ayah_number == 1 and surah_number != 1 do
      {basmalah, first_ayah} = String.split_at(ayah_text, 23)
      first_ayah
    else
      ayah_text
    end
  end

  def get_prev_page_no(page_no) do
    max(1, page_no - 1)
  end

  def get_next_page_no(page_no) do
    min(604, page_no + 1)
  end
end
