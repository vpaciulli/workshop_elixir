defmodule SimpleServer do
  def start do
    {:ok, words_pid} = Words.start_link
    {:ok, length_pid} = Agent.start_link(fn -> Words.length(words_pid) end)
    right_answer = "123456" |> Base.encode64
    pid = spawn(__MODULE__, :loop, [words_pid, right_answer, length_pid])
    :yes = :global.register_name("simple_server", pid) # register it globally
    pid
  end

  def loop(word_pid, right_answer, length_pid) do
    list_length = Words.length(word_pid)
    "Remaining List Length: [#{list_length}] of [#{Agent.get(length_pid, &(&1))}]" |> IO.puts
    receive do
      {:request, worker_pid} ->
        test_this_word = Words.pop(word_pid)
        case list_length do
          1 -> IO.puts "finished"
          _ ->
            send(worker_pid, {test_this_word, right_answer})
            loop(word_pid, right_answer, length_pid)
        end

      {true, right_word} ->
        IO.puts("======== Found the right word: #{right_word}")
        # loop(word_pid, right_answer)

      {false, _} ->
        loop(word_pid, right_answer, length_pid)
    end
  end
end
