defmodule Sup do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      Magenta,
      Green,
      Blue,
      Red,
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

end

defmodule Randy do
  def randy do
    Enum.random(1000..8000)
  end
end

defmodule Magenta do
  use GenServer
  import Randy

  @spec start_link :: :ignore | {:error, any} | {:ok, pid}
  def start_link() do
    IO.inspect("Starting process Magenta")
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
    IO.ANSI.format([:magenta, x <> IO.ANSI.reset])
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

defmodule Blue do
  use GenServer
  import Randy

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

defmodule Green do
  use GenServer
  import Randy

  def start_link() do
    IO.inspect("Starting process Green")
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
    IO.ANSI.format([:green,  "\t\t" <> x <> IO.ANSI.reset])
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

defmodule Red do
  use GenServer
  import Randy

  def start_link() do
    IO.inspect("Starting process Red")
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
    IO.ANSI.format([:red,  "\t" <> x <> IO.ANSI.reset])
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
