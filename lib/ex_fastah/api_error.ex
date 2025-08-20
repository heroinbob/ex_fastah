defmodule ExFastah.APIError do
  @moduledoc """
  An exception that represents an unsuccessful API call. Fastah's
  server returned a non 200 response
  """
  defexception [
    :message,
    :payload,
    :status
  ]
end
