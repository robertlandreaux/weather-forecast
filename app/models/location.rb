class Location < PrimaryApplicationRecord
  # TODO: add a LocationCreated RailsEventStore::Event and run the GeocodeAddressJob for US addresses only.

  validates :address_line_3, :address_line_4, :address_line_5,
    presence: true, if: -> { country_code == "US" }

  def city
    address_line_3 if us_address?
  end

  def state
    address_line_4 if us_address?
  end

  def zip_code
    address_line_5 if us_address?
  end

  def us_address?
    country_code == "US"
  end

  def address_for_geocoding
    [city, state, country_code].compact.join(", ")
  end
end
