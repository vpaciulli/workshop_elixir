defmodule SimpleServer do

  @queue = []

  def start do
    pid = spawn(__MODULE__, :loop)
    :yes = :global.register_name("simple_server", pid) # register it globally
    pid
  end

  def loop do
    receive do
      {:check, worker, "123"} -> send(worker, {:ok, "123"})
      {:new_key, worker} -> send(worker, pop)
    end
  end

  def pop([]) do
    
  end

end
