defmodule Otp.Geny do
  use GenServer

  def start_link(initial_val, color \\ "g") do
    GenServer.start_link(__MODULE__, [initial_val, color])
  end

  def init([initial_val, color]) do
    Process.send_after(self(), :inc, randy())
    {:ok, [initial_val, color]}
  end

  def handle_info(:inc, [val, color]) do
    print(to_string(val), color)
    Process.send_after(self(), :inc, randy())
    {:noreply, [val + 1, color]}
  end

  defp print(x, "r") do
    IO.puts(IO.ANSI.red <> "\t\t\t" <> x <>IO.ANSI.reset)
  end

  defp print(x, "g") do
    IO.puts(IO.ANSI.green <> "\t\t" <> x <>IO.ANSI.reset)
  end

  defp print(x, "b") do
    IO.puts(IO.ANSI.blue <> "\t" <> x <>IO.ANSI.reset)
  end

  defp print(x, "m") do
    IO.puts(IO.ANSI.magenta <> x <>IO.ANSI.reset)
  end

  defp randy() do
    Enum.random(1000..8000)
  end

end
