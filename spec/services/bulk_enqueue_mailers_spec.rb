require "rails_helper"

RSpec.describe BulkEnqueueMailers, type: :job do
  include_context "with application data"

  let(:bulk_enqueuer) {
    described_class.new(mail_class: mail_class, template: template, mailer_args: mailer_args)
  }
  let(:mail_class) { ForecastMailer }
  let(:template) { :new_forecast }
  let(:mailer_args) {
    [
      [forecast_1, user_1],
      [forecast_2, user_2]
    ]
  }

  let(:user_1) { TestProf::AnyFixture.cached(:user_1) }
  let(:user_2) { TestProf::AnyFixture.cached(:user_2) }
  let(:forecast_1) { TestProf::AnyFixture.cached(:forecast_1_us_location) }
  let(:forecast_2) { TestProf::AnyFixture.cached(:forecast_2_us_location) }

  describe "#run" do
    subject(:run) { bulk_enqueuer.run }

    before do
      allow(Sidekiq::Client).to receive(:push_bulk)
    end

    it "enqueues mailer jobs in bulk" do
      run

      expect(Sidekiq::Client).to have_received(:push_bulk).with(
        "class" => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
        "wrapped" => ActionMailer::MailDeliveryJob,
        "queue" => :mailers,
        "args" => array_including(
          array_including(
            hash_including(
              "arguments" => [
                "ForecastMailer",
                "new_forecast",
                "deliver_now",
                {"_aj_globalid" => forecast_1.to_global_id.to_s},
                {"_aj_globalid" => user_1.to_global_id.to_s}
              ]
            )
          ),
          array_including(
            hash_including(
              "arguments" => [
                "ForecastMailer",
                "new_forecast",
                "deliver_now",
                {"_aj_globalid" => forecast_2.to_global_id.to_s},
                {"_aj_globalid" => user_2.to_global_id.to_s}
              ]
            )
          )
        )
      )
    end
  end
end
