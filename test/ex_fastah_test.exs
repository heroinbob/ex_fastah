defmodule ExFastahTest do
  use ExUnit.Case, async: true

  alias ExFastah.HttpAdapters.ReqAdapter
  alias ExFastah.Location
  alias ExFastah.Test.Fixtures

  describe "where_is/1" do
    test "delegates to the adapter and returns the result" do
      Req.Test.stub(
        ReqAdapter,
        fn conn ->
          Req.Test.json(conn, Fixtures.new_york())
        end
      )

      assert {:ok, %Location{city_name: "New York City, NY"}} = ExFastah.where_is("1.2.3.4")
    end
  end
end
