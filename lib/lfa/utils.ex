defmodule LFA.Utils do
  def list_to_map(list) do
    Enum.reduce(list, %{}, fn x, acc -> Map.put(acc, x.id, x) end)
  end
end
