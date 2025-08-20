import Config

config :ex_fastah,
  fastah_key: "ima-key",
  additional_options: [
    plug: {Req.Test, ExFastah.HttpAdapters.ReqAdapter}
  ]
