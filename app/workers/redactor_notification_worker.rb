class RedactorNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    RedactorNotificationService.new.call
  end
end
