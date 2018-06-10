defmodule TicTacToe do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{
      board: Board.init
    }, opts)
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

  def handle_call({:cross, x, y}, _from, state) do
    new_board = state
    |> get_board()
    |> Board.move(:cross, x, y)
    {:reply, :ok, %{board: new_board}}
  end

  def handle_call({:circle, x, y}, _from, state) do
    new_board = state
    |> get_board()
    |> Board.move(:circle, x, y)
    {:reply, :ok, %{board: new_board}}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  defp get_board(%{ board: board }), do: board
end
