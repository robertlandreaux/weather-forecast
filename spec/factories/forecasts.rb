FactoryBot.define do
  factory :forecast do
    association :location
    date { 1.day.ago }
    data {
      {
        "today" => "Sunny. High of 80°F.",
        "tonight" => "Clear. Low of 60°F."
      }
    }
  end
end
