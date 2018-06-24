defmodule TicTacToe do
  use GenServer

  def start_link(opts) do
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

  def state(server) do
    GenServer.call(server, {:state})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:join}, _from, %{status: :waiting_for_player} = state) do
    {:reply, :ok, %{state | status: :cross_move}}
  end

  def handle_call({:join}, _from, state) do
    {:reply, :error, state}
  end

  def handle_call({:cross, _x, _y}, _from, %{status: :circle_move} = state) do
    {:reply, :error, state}
  end

  def handle_call({:circle, _x, _y}, _from, %{status: :cross_move} = state) do
    {:reply, :error, state}
  end

  def handle_call({player, x, y}, _from, %{status: status, board: board}) do
    new_board =
      board
      |> Board.move(player, x, y)

    new_status = if status == :cross_move, do: :circle_move, else: :circle_move

    {:reply, :ok, %{board: new_board, status: new_status}}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  defp get_board(%{board: board}), do: board
end
