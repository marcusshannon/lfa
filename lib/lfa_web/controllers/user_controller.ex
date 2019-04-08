defmodule LFAWeb.UserController do
  use LFAWeb, :controller

  def create(conn, params) do
    IO.inspect(params)
    {:error, changeset} = user = LFA.Users.create_user(params)

    errors =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    IO.inspect(errors)
    IO.inspect(changeset)

    conn |> redirect(to: "/react")
  end
end
