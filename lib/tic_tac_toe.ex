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

  def handle_call({:cross, _x, _y}, _from, state) do
    {:reply, :ok, state}
  end

  def handle_call({:circle, x, y}, _from, state) do
    row_x = state
    |> Enum.at(x)
    |> List.replace_at(y, :circle)

    new_state = state
    |> List.replace_at(x, row_x)
    {:reply, :ok, new_state}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end
end
