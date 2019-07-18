defmodule Spacegame.Repo do
  use Ecto.Repo,
    otp_app: :spacegame,
    adapter: Ecto.Adapters.Postgres
end
