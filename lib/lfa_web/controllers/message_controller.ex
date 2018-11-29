defmodule LFAWeb.MessageController do
  use LFAWeb, :controller

  def message(conn, _) do
    data =
      Jason.encode!(%{
        channel: "CECRWHB41",
        text: "React with your LFA rating"
      })

    {:ok, response} =
      HTTPoison.post("https://slack.com/api/chat.postMessage", data, [
        {"Content-Type", "application/json"},
        {"Authorization", "***REMOVED***"}
      ])

    # Save ts to DB, then every event, grab message reactions
    %{"ts" => ts} = Jason.decode!(response.body)

    IO.inspect(ts)

    text(conn, "ok")
  end

  def reactions(conn, _) do
    {:ok, response} =
      HTTPoison.get(
        "https://slack.com/api/reactions.get",
        [
          {"Content-Type", "application/x-www-form-urlencoded"},
          {"Authorization", "***REMOVED***"}
        ],
        params: [channel: "CECRWHB41", timestamp: "1543384548.000700", full: true]
      )

    body = Jason.decode!(response.body)
    IO.inspect(body)

    text(conn, "ok")
  end
end
