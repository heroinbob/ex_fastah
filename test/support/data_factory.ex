defmodule ExFastah.Test.DataFactory do
  use ExMachina

  def location_factory do
    %ExFastah.Location{
      city_geonames_id: 5_809_844,
      city_name: "Seattle",
      continent_code: "NA",
      country_code: "US",
      country_name: "United States",
      currency_code: "USD",
      currency_name: "Dollar",
      currency_symbol: "$",
      ip: "98.97.16.1",
      is_european_union: false,
      language_codes: ~w[en],
      latitude: 47.60621,
      longitude: -122.33207,
      satellite_provider: "",
      state_code: "WA",
      state_name: "Washington",
      time_zone: "America/Pacific"
    }
  end
end
