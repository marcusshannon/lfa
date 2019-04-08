defmodule LFAWeb.PageView do
  use LFAWeb, :view

  def render("show.json", %{initial_state: initial_state}) do
    IO.inspect(initial_state)
    %{title: "yaa"}
  end

  def render("show.json", assigns) do
    %{title: "yaa"}
  end
end
