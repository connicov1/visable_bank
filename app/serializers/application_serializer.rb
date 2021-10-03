# frozen_string_literal: true

# Base class for all serializers
# Adds wrap 'data' at root_level of the serialized response to be RESTful response
class ApplicationSerializer < ActiveModel::Serializer
  # Defines the root key for the json
  def json_key
    'data'
  end
end
