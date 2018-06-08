defmodule TicTacToe do
  use GenServer

  def start_link(opts) do
    row = [:empty, :empty, :empty]
    GenServer.start_link(__MODULE__, [row, row, row], opts)
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
    {:reply, :ok, move(:cross, x, y, state)}
  end

  def handle_call({:circle, x, y}, _from, state) do
    {:reply, :ok, move(:circle, x, y, state)}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  defp move(player, x, y, board) do
    row_x = board
    |> Enum.at(x)
    |> List.replace_at(y, player)

    board
    |> List.replace_at(x, row_x)
  end
end
