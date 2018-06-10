defmodule BoardTest do
  use ExUnit.Case

  test "identifies row_1 winner as cross" do
    winner = Board.init()
    |> List.replace_at(0, List.duplicate(:cross, 3))
    |> Board.winner()

    assert winner == :cross
  end

  test "identifies row_1 winner as circle" do
    winner = Board.init()
    |> List.replace_at(0, List.duplicate(:circle, 3))
    |> Board.winner()

    assert winner == :circle
  end

  test "identifies row_1 winner as no_winner" do
    winner = Board.init()
    |> List.replace_at(0, [:circle, :cross, :circle])
    |> Board.winner()

    assert winner == :no_winner
  end

  test "identifies empty row_1 as no_winner" do
    winner = Board.init()
    |> Board.winner()

    assert winner == :no_winner
  end

  test "identifies row_2 winner as cross" do
    winner = Board.init()
    |> List.replace_at(1, List.duplicate(:cross, 3))
    |> Board.winner()

    assert winner == :cross
  end

  test "identifies row_3 winner as circle" do
    winner = Board.init()
    |> List.replace_at(2, List.duplicate(:circle, 3))
    |> Board.winner()

    assert winner == :circle
  end

  test "identifies col_1 winner as cross" do
    winner = Board.init()
    |> List.replace_at(0, [:cross, :empty, :empty])
    |> List.replace_at(1, [:cross, :empty, :empty])
    |> List.replace_at(2, [:cross, :empty, :empty])
    |> Board.winner()

    assert winner == :cross
  end

  test "identifies col_3 winner as circle" do
    winner = Board.init()
    |> List.replace_at(0, [:empty, :empty, :circle])
    |> List.replace_at(1, [:empty, :empty, :circle])
    |> List.replace_at(2, [:empty, :empty, :circle])
    |> Board.winner()

    assert winner == :circle
  end

  test "identifies backward diagonal winner as cross" do
    winner = Board.init()
    |> List.replace_at(0, [:cross, :empty, :empty])
    |> List.replace_at(1, [:empty, :cross, :empty])
    |> List.replace_at(2, [:empty, :empty, :cross])
    |> Board.winner()

    assert winner == :cross
  end

  test "identifies forward diagonal winner as circle" do
    winner = Board.init()
    |> List.replace_at(0, [:empty, :empty, :circle])
    |> List.replace_at(1, [:empty, :circle, :empty])
    |> List.replace_at(2, [:circle, :empty, :empty])
    |> Board.winner()

    assert winner == :circle
  end
end
