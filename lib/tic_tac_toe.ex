defmodule TicTacToe do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{ init: true, x: 0, y: 0 }, opts)
  end

  def move(server, args) do
    GenServer.call(server, args)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:cross, x, y}, _from, state) do
    IO.puts "Cross: #{x}:#{y}"
    IO.inspect state
    {:reply, :ok, %{state | x: x, y: y}}
  end

  def handle_call({:circle, x, y}, _from, state) do
    IO.puts "Circle: #{x}:#{y}"
    IO.inspect state
    {:reply, :ok, %{state | x: x, y: y}}
  end
end
