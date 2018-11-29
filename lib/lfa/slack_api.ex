defmodule LFA.SlackAPI do
  def fetch_reactions(ts) do
    response =
      HTTPoison.get!(
        "https://slack.com/api/reactions.get",
        [
          {"Content-Type", "application/x-www-form-urlencoded"},
          {"Authorization", "***REMOVED***"}
        ],
        params: [channel: "CDX58FBB6", timestamp: ts, full: true]
      )

    Jason.decode!(response.body)
  end

  def post_message() do
    data =
      Jason.encode!(%{
        channel: "CDX58FBB6",
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

  def conversation_history() do
    response =
      HTTPoison.get!(
        "https://slack.com/api/conversations.history",
        [
          {"Content-Type", "application/json"},
          {"Authorization",
           "***REMOVED***"}
        ],
        params: [channel: "CDX58FBB6", limit: 10000]
      )

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
        params: [query: "from:@slackbot reminder: :lfa-1::lfa-2:", count: 100]
      )

    body = Jason.decode!(response.body)

    matches =
      body["messages"]["matches"]
      |> Enum.map(fn x -> Map.take(x, ["ts"]) end)

    Enum.each(matches, fn message ->
      {:ok, message} = LFA.Messages.create_message(message)
      reactions = fetch_reactions(message.ts)
      IO.inspect(reactions)
      reactions = LFA.Slack.transform_reactions(reactions["message"]["reactions"], message)
      Enum.each(reactions, fn reaction -> LFA.Repo.insert(reaction) end)
    end)
  end
end
