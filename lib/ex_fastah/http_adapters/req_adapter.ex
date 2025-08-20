if match?({:module, Req}, Code.ensure_compiled(Req)) do
  defmodule ExFastah.HttpAdapters.ReqAdapter do
    @moduledoc """
    An HTTP adapter that utilizes [Req](https://hexdocs.pm/req/Req.html).
    """
    @behaviour ExFastah.HttpAdapters.Behaviour

    alias ExFastah.APIError
    alias ExFastah.ConnectionError
    alias ExFastah.Location

    @default_opts [retry: false]

    @doc """
    Query the Fastah API and on success returns the `Location` for the given IP.

    ## Options

    You can control almost all aspects of the request and response by providing
    whatever options suite your needs. See the [Req](https://hexdocs.pm/req/Req.html#new/1)
    documentation for details. Please be aware the the runtime options that you pass
    in are prioritized over the configured `:additional_options`.

    ## Errors

    This adapter returns an error tuple when the request fails.

    - {:error, APIError.t()}        - When the server responds with a non 200.
    - {:error, ConnectionError.t()} - When the connection fails (no server response).
    - {:error, :invalid_ip}         - The IP that was provided is not a string.
    - {:error, :missing_api_key}    - When you didn't configure an API key.
    """
    @impl ExFastah.HttpAdapters.Behaviour
    def where_is(ip, runtime_opts \\ [])

    def where_is(ip, runtime_opts) when is_binary(ip) and is_list(runtime_opts) do
      with {:ok, api_key} <- fetch_api_key(),
           opts <- build_opts(ip, runtime_opts),
           req <- Req.new(opts),
           req <- Req.Request.put_header(req, "fastah-key", api_key),
           {:ok, %Req.Response{body: body, status: 200}} <- Req.get(req) do
        {:ok, Location.new(body)}
      else
        {:ok, %Req.Response{body: body, status: status}} ->
          {:error, APIError.exception(payload: body, status: status)}

        {:error, %{reason: reason}} ->
          # expected HTTP and TransportErrors
          {:error, ConnectionError.exception(reason: reason)}

        {:error, reason} ->
          # Missing API keys or any exception that doesn't have a reason in the exception.
          {:error, ConnectionError.exception(reason: reason)}
      end
    end

    def where_is(_ip, _opts), do: {:error, :invalid_ip}

    # Returns the options suitable for Req.new/1 and done so in a way that
    # follows expected priority and protection for critical values.
    defp build_opts(ip, runtime_opts) do
      critical_opts = [
        path_params: [ip: ip],
        url: "https://ep.api.getfastah.com/whereis/v1/json/:ip"
      ]

      configured_opts = Application.get_env(:ex_fastah, :additional_options, [])

      @default_opts
      |> Keyword.merge(configured_opts)
      |> Keyword.merge(runtime_opts)
      |> Keyword.merge(critical_opts)
    end

    defp fetch_api_key do
      case Application.fetch_env(:ex_fastah, :fastah_key) do
        {:ok, _key} = good -> good
        :error -> {:error, :missing_api_key}
      end
    end
  end
end
