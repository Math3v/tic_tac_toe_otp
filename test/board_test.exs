defmodule BoardTest do
  use ExUnit.Case

  test "identifies row_1 winner as cross" do
    winner = Board.init()
    |> List.replace_at(0, [:cross, :cross, :cross])
    |> Board.winner()

    assert winner == :cross
  end

  test "identifies row_1 winner as circle" do
    winner = Board.init()
    |> List.replace_at(0, [:circle, :circle, :circle])
    |> Board.winner()

    assert winner == :circle
  end

  test "identifies row_1 winner as no_winner" do
    winner = Board.init()
    |> List.replace_at(0, [:circle, :cross, :circle])
    |> Board.winner()

    assert winner == :no_winner
  end
end
