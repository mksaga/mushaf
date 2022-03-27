defmodule Mushaf.Repo do
  use Ecto.Repo,
    otp_app: :mushaf,
    adapter: Ecto.Adapters.Postgres
end
