defmodule NifGoBoom do
  @moduledoc """
  Documentation for `NifGoBoom`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> NifGoBoom.hello()
      :world

  """
  def hello do
    Application.get_env(:nif_go_boom, :hello, "Ruh-roh!")
  end
end
