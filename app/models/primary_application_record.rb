class PrimaryApplicationRecord < ApplicationRecord
  primary_abstract_class

  connects_to database: {writing: :primary, reading: :primary}
end
