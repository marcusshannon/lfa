defmodule LFAWeb.EventController do
  use LFAWeb, :controller
  alias LFA.Slack

  def event(conn, %{"challenge" => challenge}) do
    text(conn, challenge)
  end

  def event(conn, %{"event" => %{"item" => %{"ts" => ts}}}) do
    Slack.update_reactions(ts)
    send_resp(conn, 200, "ok")
  end
end
