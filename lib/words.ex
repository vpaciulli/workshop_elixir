defmodule Words do
  def start_link do
    Agent.start_link(fn -> gen_word_list end)
  end

  def pop(words) do
    random_position = words |> length |> :random.uniform
    Agent.get(words, fn w ->
      pop_this = elem(w, random_position)
      List.delete_at(w, random_position)
      pop_this
    end)
  end

  defp gen_word_list do
    {:ok, w} = File.read("static/passlist.txt")
    word_list = String.split(w, "\n")

    Enum.map(word_list, fn elem ->
      repetitions = :random.uniform(8)
      [elem] ++ for s <- 1..repetitions, do: sample(elem) |> to_string
    end) |> List.flatten |> List.to_tuple
  end

  defp sample(word) do
    for c <- word |> to_char_list, do: c + :random.uniform(2)
  end
end
