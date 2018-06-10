defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "get initial state", %{game: game} do
    %{board: board} = TicTacToe.state(game)
    assert board == [[:empty, :empty, :empty], [:empty, :empty, :empty], [:empty, :empty, :empty]]

    %{state: state} = TicTacToe.state(game)
    assert state == :waiting_for_player
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

  test "join player", %{game: game} do
    assert TicTacToe.join(game) == :ok
    %{state: state} = TicTacToe.state(game)
    assert state == :cross_move
  end

  test "fails to join another player", %{game: game} do
    assert TicTacToe.join(game) == :ok
    assert TicTacToe.join(game) == :error
  end
end
