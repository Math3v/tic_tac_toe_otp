defmodule Board do
  @moduledoc false

  def init() do
    :empty
    |> List.duplicate(3)
    |> List.duplicate(3)
  end

  def move(board, player, x, y) do
    new_row_x =
      board
      |> row(x)
      |> List.replace_at(y, player)

    List.replace_at(board, x, new_row_x)
  end

  def winner(board) do
    rows_winner = rows_winner(board)
    cols_winner = cols_winner(board)
    diagonal_winner = diagonals_winner(board)

    [rows_winner, cols_winner, diagonal_winner]
    |> Enum.sort()
    |> Enum.dedup()
    |> Enum.at(0)
  end

  def empty_at?(board, x, y) do
    cell =
      board
      |> Enum.at(x)
      |> Enum.at(y)

    cell == :empty
  end

  defp diagonals_winner(board) do
    forward_diagonal = forward_diagonal(board)
    backward_diagonal = backward_diagonal(board)

    rows_winner([forward_diagonal, backward_diagonal])
  end

  defp forward_diagonal(board) do
    length = Enum.count(board)
    Enum.map(0..(length - 1), fn i -> cell(board, i, length - 1 - i) end)
  end

  defp backward_diagonal(board) do
    length = Enum.count(board)
    Enum.map(0..(length - 1), fn i -> cell(board, i, i) end)
  end

  defp cols_winner(board) do
    board
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> rows_winner()
  end

  defp rows_winner(board) do
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

  defp cell(board, x, y) do
    board
    |> Enum.at(x)
    |> Enum.at(y)
  end
end
