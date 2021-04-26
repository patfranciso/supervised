defmodule Otp.Application do
  alias Otp.{Magenta, Red, Blue, Green}

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Magenta,
      Green,
      Blue,
      Red,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    # :observer.start()
    opts = [strategy: :one_for_one, name: Otp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
