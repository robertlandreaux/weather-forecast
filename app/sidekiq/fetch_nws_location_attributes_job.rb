# frozen_string_literal: true

class FetchNwsLocationAttributesJob
  include Sidekiq::Job

  def perform
    Locations::FetchLocationAttributes.new.run
  end
end
