defmodule ListElements do
  def print_all(list) do
    Enum.map(list, fn (x) -> IO.puts x end)
  end

  def print_all_2(list) do
    Enum.map(list, IO.puts)
  end

  def print([]), do: :ok
  def print(lista) do
    [head | tail] = lista
    IO.puts head

    print tail
  end

end
