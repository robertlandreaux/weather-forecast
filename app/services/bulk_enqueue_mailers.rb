class BulkEnqueueMailers
  # @param mail_class [Class] The mailer class
  # @param template [Symbol] The mailer template method
  # @param mailer_args [Array<Array>] An array of argument arrays for the mailer
  def initialize(mail_class:, template:, mailer_args:)
    @mail_class = mail_class
    @template = template
    @mailer_args = mailer_args
    @job = ActionMailer::MailDeliveryJob
  end

  def run
    Sidekiq::Client.push_bulk(
      "class" => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
      "wrapped" => job,
      "queue" => :mailers,
      "args" => mail_job_args
    )
  end

  private

  attr_reader :mail_class
  attr_reader :mailer_args
  attr_reader :job
  attr_reader :template

  def mail_job_args
    mailer_args.map { |args|
      [job.new(
        mail_class.name,
        template.to_s,
        "deliver_now",
        *args
      ).serialize]
    }
  end
end
