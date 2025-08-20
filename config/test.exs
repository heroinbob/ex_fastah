import Config

config :ex_fastah,
  fastah_key: "ima-key",
  http_adapter: ExFastah.HttpAdapters.MockHttpAdapter,
  additional_options: [
    plug: {Req.Test, ExFastah.HttpAdapters.ReqAdapter}
  ]
