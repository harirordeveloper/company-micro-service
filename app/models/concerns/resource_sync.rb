module ResourceSync
  extend ActiveSupport::Concern

  module ClassMethods
    def sync_data(message)
      action = message[:action]
      data = message[:data].with_indifferent_access
      case action
      when 'create'
        create_resource data
      when 'update'
        update_resource data
      when 'delete'
        delete_resource data
      end
    end

    def create_resource attrs
      resource = create(attrs)
      Rails.logger.info("Created #{self.name} :: #{resource.id }")
    end

    def update_resource attrs
      resource = find_by_id(attrs[:id])
      if resource.present?
        resource.update(attrs)
        Rails.logger.info("Update #{self.name} #{resource.id }")
      end
    end

    def delete_resource attrs
      resource = find_by_id(attrs[:id])
      if resource.present?
        resource.delete
        Rails.logger.info("Deleted #{self.name } #{resource.id }")
      end
    end
  end
end
