class Location < PrimaryApplicationRecord
  US_STATES = {
    "AL" => "Alabama",
    "AK" => "Alaska",
    "AZ" => "Arizona",
    "AR" => "Arkansas",
    "CA" => "California",
    "CO" => "Colorado",
    "CT" => "Connecticut",
    "DE" => "Delaware",
    "DC" => "District of Columbia",
    "FL" => "Florida",
    "GA" => "Georgia",
    "HI" => "Hawaii",
    "ID" => "Idaho",
    "IL" => "Illinois",
    "IN" => "Indiana",
    "IA" => "Iowa",
    "KS" => "Kansas",
    "KY" => "Kentucky",
    "LA" => "Louisiana",
    "ME" => "Maine",
    "MD" => "Maryland",
    "MA" => "Massachusetts",
    "MI" => "Michigan",
    "MN" => "Minnesota",
    "MS" => "Mississippi",
    "MO" => "Missouri",
    "MT" => "Montana",
    "NE" => "Nebraska",
    "NV" => "Nevada",
    "NH" => "New Hampshire",
    "NJ" => "New Jersey",
    "NM" => "New Mexico",
    "NY" => "New York",
    "NC" => "North Carolina",
    "ND" => "North Dakota",
    "OH" => "Ohio",
    "OK" => "Oklahoma",
    "OR" => "Oregon",
    "PA" => "Pennsylvania",
    "RI" => "Rhode Island",
    "SC" => "South Carolina",
    "SD" => "South Dakota",
    "TN" => "Tennessee",
    "TX" => "Texas",
    "UT" => "Utah",
    "VT" => "Vermont",
    "VA" => "Virginia",
    "WA" => "Washington",
    "WV" => "West Virginia",
    "WI" => "Wisconsin",
    "WY" => "Wyoming"
  }

  has_prefix_id :loc

  validates :country_code, presence: true
  validate :us_address_required_fields
  validates :address_line_4, inclusion: {in: US_STATES.keys}, if: :us_address?
  validates(
    :address_line_3,
    uniqueness: {
      scope: %i[address_line_4 address_line_5 country_code],
      message: "combination of City, State, Zip Code, and Country Code must be unique"
    },
    if: :us_address?
  )

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
    [address_line_3, address_line_4, address_line_5].compact.join(", ")
  end

  private

  def us_address_required_fields
    return unless country_code == "US"

    errors.add(:base, "City can't be blank") if city.blank?
    errors.add(:base, "State can't be blank") if state.blank?
    errors.add(:base, "Zip Code can't be blank") if zip_code.blank?
  end
end
