defmodule MushafWeb.TextView do
  use MushafWeb, :view

  def get_ayah_id(ayah) do
    surah_no = elem(ayah, 0)
    ayah_no = elem(ayah, 1)
    "#{surah_no}-#{ayah_no}"
  end

  def get_ayah_text(ayah) do
    elem(ayah, 2)
    ayah_text = elem(ayah, 2)
    ayah_number = elem(ayah, 1)
    surah_number = elem(ayah, 0)
    if ayah_number == 1 and surah_number != 1 do
      {basmalah, first_ayah} = String.split_at(ayah_text, 23)
      basmalah <> "\n" <> first_ayah
    else
      ayah_text
    end
  end
  end

  def get_prev_page_no(page_no) do
    max(1, page_no - 1)
  end

  def get_next_page_no(page_no) do
    min(604, page_no + 1)
  end
end
