class BulkEnqueueMailers
  def run(mail_class, template, args_array)
    job = ActionMailer::MailDeliveryJob

    mailer_job_args = args_array.map { |args|
      [job.new(
        mail_class.name,
        template.to_s,
        "deliver_now",
        *args
      ).serialize]
    }

    Sidekiq::Client.push_bulk(
      "class" => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
      "wrapped" => job,
      "queue" => :mailers,
      "args" => mailer_job_args
    )
  end
end
