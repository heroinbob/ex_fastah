defmodule ExFastah.HttpAdapters.ReqAdapterTest do
  use ExUnit.Case, async: true

  alias ExFastah.APIError
  alias ExFastah.ConnectionError
  alias ExFastah.HttpAdapters.ReqAdapter
  alias ExFastah.Location
  alias ExFastah.Test.Fixtures

  describe "where_is/1" do
    test "returns a location when the lookup is successful" do
      Req.Test.expect(
        ReqAdapter,
        1,
        fn conn ->
          assert conn.host == "ep.api.getfastah.com"
          assert conn.port == 443
          assert conn.scheme == :https
          assert conn.method == "GET"
          assert {"fastah-key", "ima-key"} in conn.req_headers
          assert conn.request_path == "/whereis/v1/json/1.2.3.4"

          Req.Test.json(conn, Fixtures.new_york())
        end
      )

      assert ReqAdapter.where_is("1.2.3.4") == %Location{
               city_geonames_id: 0,
               city_name: "New York City, NY",
               continent_code: "NA",
               country_code: "US",
               country_name: "United States",
               currency_code: "USD",
               currency_name: "Dollar",
               currency_symbol: "$",
               ip: "98.97.16.1",
               is_european_union: false,
               language_codes: ["en"],
               latitude: 42.36,
               longitude: -71.06,
               satellite_provider: "",
               state_code: "",
               state_name: "",
               time_zone: "America/New_York"
             }

      Req.Test.verify!()
    end

    test "returns an error when the response is not 200" do
      access_denied = Fixtures.access_denied()

      Req.Test.stub(ReqAdapter, fn conn ->
        conn
        |> Plug.Conn.put_status(401)
        |> Req.Test.json(access_denied)
      end)

      assert ReqAdapter.where_is("1.2.3.4") == {
               :error,
               %APIError{payload: access_denied, status: 401}
             }
    end

    test "returns an error when the connection fails" do
      Req.Test.stub(ReqAdapter, fn conn ->
        Req.Test.transport_error(conn, :timeout)
      end)

      assert {
               :error,
               %ConnectionError{reason: :timeout}
             } = ReqAdapter.where_is("1.2.3.4", retry: false)
    end
  end
end
