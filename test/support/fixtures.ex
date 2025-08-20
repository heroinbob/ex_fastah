defmodule ExFastah.Test.Fixtures do
  @moduledoc false
  @access_denied %{
    "message" =>
      "Access denied due to missing subscription key. Make sure to include subscription key when making requests to an API.",
    "statusCode" => 401
  }

  def access_denied, do: @access_denied

  @new_york %{
    "ip" => "98.97.16.1",
    "isEuropeanUnion" => false,
    "locationData" => %{
      "countryName" => "United States",
      "countryCode" => "US",
      "stateName" => "",
      "stateCode" => "",
      "cityName" => "New York City, NY",
      "cityGeonamesId" => 0,
      "lat" => 42.36,
      "lng" => -71.06,
      "tz" => "America/New_York",
      "continentCode" => "NA"
    },
    "l10n" => %{
      "currencyName" => "Dollar",
      "currencyCode" => "USD",
      "currencySymbol" => "$",
      "langCodes" => ["en"]
    },
    "satellite" => %{
      "provider" => ""
    }
  }

  def new_york, do: @new_york
end
