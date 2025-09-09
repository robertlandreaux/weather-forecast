class LogExternalRequestJob
  include Sidekiq::Job
  sidekiq_options queue: :logging

  def perform(
    request_method,
    request_headers,
    request_url,
    request_body,
    response_headers,
    response_status,
    response_body,
    metadata
  )
    ExternalRequestLog.create!(
      request_method:,
      request_headers:,
      request_url:,
      request_body:,
      response_headers:,
      response_status:,
      response_body:,
      metadata:
    )
  end
end
