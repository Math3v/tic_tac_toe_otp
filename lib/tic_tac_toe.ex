defmodule TicTacToe do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{
      state: :waiting_for_player,
      board: Board.init
    }, opts)
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

  def handle_call({:join}, _from, %{state: :waiting_for_player} = state) do
    {:reply, :ok, %{state | state: :cross_move}}
  end

  def handle_call({:join}, _from, state) do
    {:reply, :error, state}
  end

  def handle_call({player, x, y}, _from, state) do
    new_board = state
    |> get_board()
    |> Board.move(player, x, y)
    {:reply, :ok, %{board: new_board}}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  defp get_board(%{ board: board }), do: board
end
