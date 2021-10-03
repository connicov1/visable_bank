class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :set_uuid

  # Generates uuid and sets it as id if not specified
  def set_uuid
    self.id ||= SecureRandom.uuid
  end

  # Defines a helper to serialize the model objects
  def serialized
    serializer_class.new(self).serializable_hash
  end
end
