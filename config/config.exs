import Config

config :ex_fastah, http_adapter: ExFastah.HttpAdapters.ReqAdapter

if Mix.env() == :test, do: import_config("test.exs")
