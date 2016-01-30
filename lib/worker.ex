defmodule Worker do

  def start do
    pid = spawn(__MODULE__, :loop, [])
    send(server_pid, {:request, pid})
    pid
  end

  def server_pid do
    :global.whereis_name("simple_server")
  end

  def loop do
    receive do
      {raw, hash}  ->
        send(server_pid, eq?(raw, hash))
        send(server_pid, {:request, self()})
        loop
    end
  end

  def eq?(raw, hash) do
    return {hash == Base.encode64(raw), raw}
  end
end
