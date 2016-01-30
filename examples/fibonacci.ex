defmodule Fibonacci do
  def print(n) when n <= 2 do
      1
  end

  def print (n)  do
    print(n - 1) + print(n - 2);
  end

  def start(x) do IO.puts print(x) end
end
