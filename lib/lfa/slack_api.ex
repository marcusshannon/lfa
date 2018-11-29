defmodule LFA.SlackAPI do
  def fetch_reactions(ts) do
    response =
      HTTPoison.get!(
        "https://slack.com/api/reactions.get",
        [
          {"Content-Type", "application/x-www-form-urlencoded"},
          {"Authorization", "***REMOVED***"}
        ],
        params: [channel: "CECRWHB41", timestamp: ts, full: true]
      )

    Jason.decode!(response.body)
  end

  def post_message() do
    data =
      Jason.encode!(%{
        channel: "CECRWHB41",
        text: "React with your LFA rating"
      })

    response =
      HTTPoison.post!("https://slack.com/api/chat.postMessage", data, [
        {"Content-Type", "application/json"},
        {"Authorization", "***REMOVED***"}
      ])

    Jason.decode!(response.body)
  end

  def list_users() do
    response =
      HTTPoison.get!("https://slack.com/api/users.list", [
        {"Content-Type", "application/json"},
        {"Authorization", "***REMOVED***"}
      ])

    Jason.decode!(response.body)
  end

  def search_messages() do
    response =
      HTTPoison.get!(
        "https://slack.com/api/search.messages",
        [
          {"Content-Type", "application/json"},
          {"Authorization",
           "***REMOVED***"}
        ],
        params: [query: "Reminder: :lfa-1::lfa-2:", count: 100]
      )

    Jason.decode!(response.body)
  end
end
