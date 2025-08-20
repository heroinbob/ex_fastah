if match?({:module, Req}, Code.ensure_compiled(Req)) do
  defmodule ExFastah.HttpAdapters.ReqAdapter do
    @moduledoc """
    An HTTP adapter that utilizes [Req](https://hexdocs.pm/req/Req.html).
    """
    @behaviour ExFastah.HttpAdapters.Behaviour

    alias ExFastah.APIError
    alias ExFastah.ConnectionError
    alias ExFastah.Location

    @doc """
    Query the Fastah API and on success returns the `Location` for the given IP.

    ## Options

    You can control almost all aspects of the request and response by providing
    whatever options suite your needs. See the [Req](https://hexdocs.pm/req/Req.html#new/1)
    documentation for details.
    """
    @impl ExFastah.HttpAdapters.Behaviour
    def where_is(ip, opts \\ [])

    def where_is(ip, opts) when is_binary(ip) do
      opts =
        Keyword.merge(
          opts,
          path_params: [ip: ip],
          url: "https://ep.api.getfastah.com/whereis/v1/json/:ip"
        )

      with {:ok, api_key} <- fetch_api_key(),
           req <- Req.new(opts),
           addl_opts <- Application.get_env(:ex_fastah, :additional_options, []),
           req <- Req.Request.merge_options(req, addl_opts),
           req <- Req.Request.put_header(req, "fastah-key", api_key),
           {:ok, %Req.Response{body: body, status: 200}} <- Req.get(req, opts) do
        Location.new(body)
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

    defp fetch_api_key do
      case Application.fetch_env(:ex_fastah, :fastah_key) do
        {:ok, _key} = good -> good
        :error -> {:error, :missing_api_key}
      end
    end
  end
end
