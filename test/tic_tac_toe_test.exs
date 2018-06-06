defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "get initial state", %{game: game} do
    assert TicTacToe.state(game) == [[:empty, :empty, :empty], [:empty, :empty, :empty], [:empty, :empty, :empty]]
  end

  test "circle move", %{game: game} do
    assert TicTacToe.move(game, {:circle, 1, 2}) == :ok
    state = TicTacToe.state(game)
    row_1 = state |> Enum.at(1)
    assert row_1 == [:empty, :empty, :circle]
  end

  test "cross move", %{game: game} do
    assert TicTacToe.move(game, {:cross, 2, 5}) == :ok
  end
end
