defmodule ExFastah.HttpAdapters.Behaviour do
  @moduledoc """
  The behaviour for all HTTP adapters that ExFastah can utilize.
  """
  @callback where_is(ip :: String.t()) :: {:ok, ExFastah.Location.t()} | {:error, term()}
  @callback where_is(ip :: String.t(), opts :: keyword()) ::
              {:ok, ExFastah.Location.t()} | {:error, term()}
end
