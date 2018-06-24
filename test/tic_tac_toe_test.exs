defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "join player", %{game: game} do
    assert TicTacToe.join(game) == {:ok, :cross_move}
  end

  test "fails to join another player", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
    {:error, _reason} = TicTacToe.join(game)
  end

  test "fails to move the same player twice", %{game: game} do
    assert TicTacToe.move(game, {:cross, 2, 2}) == :ok
    assert TicTacToe.move(game, {:cross, 1, 2}) == :error
  end

  test "fails to move to a taken cell", %{game: game} do
    assert TicTacToe.move(game, {:cross, 2, 2}) == :ok
    assert TicTacToe.move(game, {:circle, 2, 2}) == :error
  end
end
