defmodule SimpleServer do
  def start do
    words_pid = Words.start_link
    right_answer = "123456" |> Base64.encode64
    pid = spawn(__MODULE__, :loop, [words_pid, right_answer])
    :yes = :global.register_name("simple_server", pid) # register it globally
    pid
  end

  def loop(word_pid, right_answer) do
    receive do
      {:request, worker_pid} ->
        test_this_word = Words.pop(word_pid)
        send(worker_pid, [test_this_word, right_answer])
        loop(word_pid, right_answer)

      {true, right_word} ->
        IO.puts("======== Found the right word: #{right_word}")
        loop(word_pid, right_answer)

      {false, _} ->
        loop(word_pid, right_answer)
    end
  end
end
