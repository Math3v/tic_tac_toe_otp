defmodule Board do

  def init() do
    :empty
    |> List.duplicate(3)
    |> List.duplicate(3)
  end

  def move(board, player, x, y) do
    new_row_x = board
    |> row(x)
    |> List.replace_at(y, player)

    board
    |> List.replace_at(x, new_row_x)
  end

  defp row(board, x), do: Enum.at(board, x)
end
