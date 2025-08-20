# ExFastah

An elixir library that provides HTTP access to the Fastah API.

## Installation

Define `:ex_fastah` in your mix.exs file along with the `:req` dependency.
`Req` is defined as optional so that you can use your own adapter without having
to rely on unwanted dependencies.

```elixir
def deps do
  [
    {:ex_fastah, "~> 0.1.0"},
    # Needed for `ExFastah.HttpAdapters.ReqAdapter`
    {:req, "~> 0.5.15"}
  ]
end
```

If your project has other needs then you can just add `:ex_fastah` to the project
deps and configure your own adapter. Please see the configuration section below for details.

```elixir
def deps do
  [
    {:ex_fastah, "~> 0.1.0"}
  ]
end
```

## Providing a custom adapter

When you don't want to rely on `ReqAdapter` you can define your own in the application config.

```elixir
config :ex_fastah, http_adapter: MyApp.OtherAdapter
```
