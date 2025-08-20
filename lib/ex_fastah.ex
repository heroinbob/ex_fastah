defmodule ExFastah do
  @moduledoc """
  A simple library to interact with the [Fastah API](https://www.getfastah.com/).
  """
  @http_adapter Application.compile_env!(:ex_fastah, :http_adapter)

  @doc """
  Look up the given IP and return the `Location`.

  ## Configuration

  You'll need to define our Fastah API key for authentication.

  ```elixir
  config :ex_fastah, :fastah_key, "my-key"
  ```

  You can optionally define `:additional_options` in the config that will be used
  for all HTTP requests. This way you can add configuration without needing to
  provide defaults as options in the codebase. Be aware that when you define
  additional options in the config - they are overridden by runtime options provided
  in the codebase.

  See the options section below for supported values.

  ```elixir
  config :ex_fastah, :additional_options, [retry: :transient]
  ````

  ## Options

  Options can be passed in to provide additional control of the requests and responses.
  Please refer to the [Req documentation](https://hexdocs.pm/req/Req.html#new/1) for details.

  ## Retries

  It's important to understand that `ExFastah` is configured to never automatically retry a
  failed request. However, there is robust support for automatic retries. You can enable and
  customize this in the options.

  ## Using a custom HTTP adapter

  The `ReqAdapter` supports almost total control of the requests, responses and even the HTTP
  adapter that is used to execute the HTTP request. By default [Finch](https://hexdocs.pm/finch/Finch.html)
  executes the HTTP requests but you can change that easily in the options.

  That said, If your app already relies on an HTTP adatper and you don't want to add any
  additional dependencies then you can create your own adapter. `Req` is an optional
  dependency in this library. If it's not available then the `ReqAdapter` is not compiled and
  included in this library.

  1. Implement your module and be sure it relies on the behaviour `ExFastah.HttpAdapters.Behaviour`.
  2. Add the `:http_adapter` config value for `:ex_fastah` in your application config.

  Example:

  ```elixir
  config :ex_fastah, :http_adapter, MyApp.SomeOtherHttpAdapter
  ````
  """
  defdelegate where_is(ip), to: @http_adapter
  defdelegate where_is(ip, opts), to: @http_adapter
end
