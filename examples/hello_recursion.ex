defmodule Recursion do
  def print(x) when x >= 1 do
    IO.puts "Hello Elixir"
     print(x-1)
  end
  def print(0), do: {:ok, "Agora sim, deu tudo bem"}

end
