class CompanyServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  ADMIN_SERVICE = "admin_service"

  def perform(message)
    message = eval(message)
    if message[:service_id] == ADMIN_SERVICE
      AdminKafkaSubscriberService.sync_data(message)
    end
  end
end
