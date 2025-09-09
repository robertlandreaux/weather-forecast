require "rails_helper"

RSpec.describe LogExternalRequestJob do
  let(:job) { described_class.new }

  describe "#perform" do
    subject(:perform) {
      job.perform(
        request_method,
        request_headers,
        request_url,
        request_body,
        response_headers,
        response_status,
        response_body,
        metadata
      )
    }

    let(:request_method) { :get }
    let(:request_headers) { "{User-Agent: 'test'}" }
    let(:request_url) { "https://example.com/test" }
    let(:request_body) { "{pippo: true}" }
    let(:response_headers) { "{X-Correlation-Id: '123test'}" }
    let(:response_status) { 200 }
    let(:response_body) { "{success: true}" }
    let(:metadata) { "{foo: 'bar}" }

    it "creates an ExternalRequestLog record" do
      expect { perform }.to change(ExternalRequestLog, :count).by(1)
      expect(ExternalRequestLog.last).to have_attributes(
        request_method: "get",
        request_headers:,
        request_url:,
        request_body:,
        response_headers:,
        response_status:,
        response_body:,
        metadata: metadata
      )
    end
  end
end
