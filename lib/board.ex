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

  def winner(board) do
    board
    |> Enum.at(0)
    |> row_winner()
  end

  defp row_winner(row) do
    first = row |> List.first
    Enum.reduce_while(row, first, &same_winner/2)
  end

  defp same_winner(w, w), do: {:cont, w}
  defp same_winner(_, _), do: {:halt, :no_winner}

  defp row(board, x), do: Enum.at(board, x)
end
