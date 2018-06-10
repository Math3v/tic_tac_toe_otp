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
    |> Enum.map(&row_winner/1)
    |> Enum.drop_while(fn i -> i == :no_winner end)
    |> board_winner()
  end

  defp board_winner([]), do: :no_winner
  defp board_winner(winners), do: List.first(winners)

  defp row_winner([:cross, :cross, :cross]), do: :cross
  defp row_winner([:circle, :circle, :circle]), do: :circle
  defp row_winner(_), do: :no_winner

  defp row(board, x), do: Enum.at(board, x)
end
