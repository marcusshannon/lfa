defmodule LFA.Graph do
  import Ecto.Query, warn: false
  alias LFA.Repo

  alias LFA.Messages.Message
  alias LFA.Reactions.Reaction
  alias LFA.Users.User

  def ts_to_date(ts) do
    {unix, _} = Integer.parse(ts)

    DateTime.from_unix!(unix)
    |> DateTime.to_date()
    |> Date.to_string()
  end
end
