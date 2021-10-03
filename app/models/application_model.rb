# frozen_string_literal: true

# Base class for all models
class ApplicationModel
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Attributes
  include ActiveModel::Serialization

  class << self
    # Defines the model attributes
    def attributes(*attribute_names)
      attribute_names.each do |attribute_name|
        attribute(attribute_name)
      end
    end
  end

  # Defines a helper to return the serialized attributes of model objects
  #
  # @return [Hash]
  def serialized_attributes
    serializer_class.new(self).as_json
  end
end
