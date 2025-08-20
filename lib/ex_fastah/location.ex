defmodule ExFastah.Location do
  @moduledoc """
  A data structure that represents a location for an IP.
  """
  @type t :: %__MODULE__{
          city_geonames_id: non_neg_integer(),
          city_name: String.t(),
          continent_code: String.t(),
          country_code: String.t(),
          country_name: String.t(),
          currency_code: String.t(),
          currency_name: String.t(),
          currency_symbol: String.t(),
          ip: String.t(),
          is_european_union: boolean(),
          language_codes: [String.t()],
          latitude: float(),
          longitude: float(),
          satellite_provider: String.t(),
          state_code: String.t(),
          state_name: String.t(),
          time_zone: String.t()
        }

  defstruct [
    :city_geonames_id,
    :city_name,
    :continent_code,
    :country_code,
    :country_name,
    :currency_code,
    :currency_name,
    :currency_symbol,
    :ip,
    :is_european_union,
    :language_codes,
    :latitude,
    :longitude,
    :satellite_provider,
    :state_code,
    :state_name,
    :time_zone
  ]

  @doc """
  Returns a new location for the given data from Fastah.
  """
  @spec new(info :: map()) :: t()
  def new(%{
        "ip" => ip,
        "isEuropeanUnion" => is_eu,
        "l10n" => %{
          "currencyCode" => currency_code,
          "currencyName" => currency_name,
          "currencySymbol" => currency_symbol,
          "langCodes" => language_codes
        },
        "locationData" => %{
          "cityGeonamesId" => city_geonames_id,
          "cityName" => city_name,
          "continentCode" => continent_code,
          "countryCode" => country_code,
          "countryName" => country_name,
          "lat" => lat,
          "lng" => long,
          "stateCode" => state_code,
          "stateName" => state_name,
          "tz" => time_zone
        },
        "satellite" => %{"provider" => satellite_provider}
      }) do
    %__MODULE__{
      city_geonames_id: city_geonames_id,
      city_name: city_name,
      continent_code: continent_code,
      country_code: country_code,
      country_name: country_name,
      currency_code: currency_code,
      currency_name: currency_name,
      currency_symbol: currency_symbol,
      ip: ip,
      is_european_union: is_eu,
      language_codes: language_codes,
      latitude: lat,
      longitude: long,
      satellite_provider: satellite_provider,
      state_code: state_code,
      state_name: state_name,
      time_zone: time_zone
    }
  end
end
