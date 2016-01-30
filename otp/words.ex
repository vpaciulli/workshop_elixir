defmodule Words do
  def start_link do
    Agent.start_link(fn -> gen_word_list end)
  end

  def pop(words) do
    length = words |> Agent.get(&(&1)) |> tuple_size
    poped = words |> Agent.get(&(elem(&1, 0)))
    case length do
      0 -> IO.puts "list finished"
      _ -> Agent.update(words, &(Tuple.delete_at(&1, 0)))
    end
    poped
  end

  def length(words) do
    Agent.get(words, &(&1)) |> tuple_size
  end

  defp gen_word_list do
    {:ok, w} = File.read("static/passlist.txt")
    word_list = String.split(w, "\n")

    Enum.map(word_list, fn elem ->
      repetitions = :random.uniform(999)
      [elem] ++ for _ <- 1..repetitions, do: sample(elem) |> to_string
    end) |> List.flatten |> Enum.shuffle |> List.to_tuple
  end

  defp sample(word) do
    for c <- word |> to_char_list, do: c + :random.uniform(2)
  end
end
