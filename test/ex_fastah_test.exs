defmodule ExFastahTest do
  use ExUnit.Case, async: true

  alias ExFastah.HttpAdapters.MockHttpAdapter
  alias ExFastah.Test.DataFactory

  import Hammox

  setup :verify_on_exit!

  describe "where_is/1" do
    test "delegates to the adapter and returns the result" do
      location = DataFactory.build(:location)

      expect(
        MockHttpAdapter,
        :where_is,
        fn ip ->
          assert ip == "1.2.3.4"

          {:ok, location}
        end
      )

      assert ExFastah.where_is("1.2.3.4") == {:ok, location}
    end
  end
end
