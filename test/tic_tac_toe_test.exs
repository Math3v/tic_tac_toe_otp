defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  setup do
    game = start_supervised!(TicTacToe)
    %{game: game}
  end

  test "joins a player", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
  end

  test "handles a game", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
    {:ok, %{status: :circle_move}} = TicTacToe.move(game, {:cross, 0, 0})
    {:ok, %{status: :cross_move}} = TicTacToe.move(game, {:circle, 1, 2})
    {:ok, %{status: :circle_move}} = TicTacToe.move(game, {:cross, 1, 1})
    {:ok, %{status: :cross_move}} = TicTacToe.move(game, {:circle, 1, 0})
    {:ok, %{status: :cross_won}} = TicTacToe.move(game, {:cross, 2, 2})
  end

  test "fails to join another player", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
    {:error, _reason} = TicTacToe.join(game)
  end

  test "fails to move the same player twice", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
    {:ok, %{status: :circle_move}} = TicTacToe.move(game, {:cross, 2, 2})
    {:error, _reason} = TicTacToe.move(game, {:cross, 1, 2})
  end

  test "fails to move to a taken cell", %{game: game} do
    {:ok, :cross_move} = TicTacToe.join(game)
    {:ok, %{status: :circle_move}} = TicTacToe.move(game, {:cross, 2, 2})
    {:error, _reason} = TicTacToe.move(game, {:circle, 2, 2})
  end
end
