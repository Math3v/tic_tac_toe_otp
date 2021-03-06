defmodule TicTacToe do
  @moduledoc false

  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      %{
        status: :waiting_for_player,
        board: Board.init()
      },
      opts
    )
  end

  def join(server) do
    GenServer.call(server, {:join})
  end

  def move(server, args) do
    GenServer.call(server, args)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:join}, _from, %{status: :waiting_for_player} = state) do
    {:reply, {:ok, :cross_move}, %{state | status: :cross_move}}
  end

  def handle_call({:join}, _from, state) do
    {:reply, {:error, "Cannot join more than 2 players"}, state}
  end

  def handle_call({:cross, _x, _y}, _from, %{status: :circle_move} = state) do
    {:reply, {:error, "Please, wait for your oponent to move."}, state}
  end

  def handle_call({:circle, _x, _y}, _from, %{status: :cross_move} = state) do
    {:reply, {:error, "Please, wait for your oponent to move."}, state}
  end

  def handle_call({player, x, y}, _from, %{status: status, board: board} = state) do
    with true <- Board.empty_at?(board, x, y),
         new_board <- Board.move(board, player, x, y),
         winner <- Board.winner(new_board),
         new_status <- next_status(status, winner),
         new_state <- %{board: new_board, status: new_status} do
      {:reply, {:ok, new_state}, new_state}
    else
      false -> {:reply, {:error, "Cannot move there"}, state}
    end
  end

  defp next_status(:cross_move, :no_winner), do: :circle_move
  defp next_status(:circle_move, :no_winner), do: :cross_move
  defp next_status(_, :cross), do: :cross_won
  defp next_status(_, :circle), do: :circle_won
end
