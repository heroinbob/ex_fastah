defmodule ExFastah.Test.Context do
  @moduledoc false
  def override_config(overrides, test_fn) do
    orig_config = Application.get_all_env(:ex_fastah)

    for {key, value} <- overrides, do: Application.put_env(:ex_fastah, key, value)

    test_fn.()

    Application.put_all_env(ex_fastah: orig_config)
  end
end
