defmodule Otp.Randy do
  def randy do
    Enum.random(1000..8000)
  end
end
