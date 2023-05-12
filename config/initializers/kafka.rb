require "#{Rails.root}/app/services/kafka_service"

KafkaService.consume("employee")
KafkaService.consume("admin_employee")
KafkaService.consume("company")
