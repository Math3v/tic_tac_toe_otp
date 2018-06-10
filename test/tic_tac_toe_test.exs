defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "get initial state", %{game: game} do
    board = TicTacToe.state(game)
    |> Map.get(:board)
    assert board == [[:empty, :empty, :empty], [:empty, :empty, :empty], [:empty, :empty, :empty]]
  end

  test "circle move", %{game: game} do
    assert TicTacToe.move(game, {:circle, 1, 2}) == :ok
    %{board: board} = TicTacToe.state(game)
    row_1 = board |> Enum.at(1)
    assert row_1 == [:empty, :empty, :circle]
  end

  test "cross move", %{game: game} do
    assert TicTacToe.move(game, {:cross, 2, 2}) == :ok
    %{board: board} = TicTacToe.state(game)
    row_2 = board |> Enum.at(2)
    assert row_2 == [:empty, :empty, :cross]
  end
end
