require "rails_helper"

RSpec.describe Forecasts::FetchForecastJob, type: :job do
  let(:job) { described_class.new }

  describe "#perform" do
    subject(:perform) { job.perform(1) }

    before do
      allow(Forecasts::FetchForecastService).to receive(:new).and_return(service)
    end

    let(:service) { instance_double(Forecasts::FetchForecastService, run: true) }

    it "uses Forecasts::FetchForecastService#run" do
      perform
      expect(Forecasts::FetchForecastService).to have_received(:new).with(location_id: 1)
      expect(service).to have_received(:run)
    end
  end
end
