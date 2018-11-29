defmodule LFA.Poster do
  alias LFA.SlackAPI
  alias LFA.Messages

  def send() do
    SlackAPI.post_message()
    |> Messages.create_message()
  end
end
