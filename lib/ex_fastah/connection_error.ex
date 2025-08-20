defmodule ExFastah.ConnectionError do
  @moduledoc """
  An exception that represents an error when no response was received
  from Fastah.
  """
  defexception [:message, :reason]
end
