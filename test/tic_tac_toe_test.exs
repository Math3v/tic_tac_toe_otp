defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "cross move", %{game: game} do
    assert TicTacToe.move(game, {:cross, 1, 2}) == :ok
  end

  test "circle move", %{game: game} do
    assert TicTacToe.move(game, {:circle, 2, 5}) == :ok
  end
end
