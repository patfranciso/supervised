defmodule Otp.Blue do
  use GenServer
  import Otp.Randy

  def start_link() do
    IO.inspect("Starting process Blue")
    GenServer.start_link(__MODULE__, 0)
  end

  def init(initial_val) do
    Process.send_after(self(), :inc, randy())
    {:ok, initial_val}
  end

  def handle_info(:inc, val) do
    print(to_string(val))
    Process.send_after(self(), :inc, randy())
    {:noreply, val + 1}
  end

  defp print(x) do
    IO.ANSI.format([:blue,  "\t\t\t" <> x <> IO.ANSI.reset])
    |> IO.puts
  end

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      name: __MODULE__
    }
  end
end
