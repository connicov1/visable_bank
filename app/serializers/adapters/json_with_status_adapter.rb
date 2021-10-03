# frozen_string_literal: true

# Implements Adapters module
module Adapters
  # Custom JSON adapter based on the REST standard JSON Adapter
  class JSONWithStatusAdapter < ActiveModelSerializers::Adapter::Base
    # Adapter definition based on the standard JSON Adapter
    def serializable_hash(options = nil)
      options = serialization_options(options)
      serialized_hash = meta if meta.present?
      serialized_hash[root] = ActiveModelSerializers::Adapter::Attributes.new(
                                serializer, instance_options
                              ).serializable_hash(options)

      self.class.transform_key_casing!(serialized_hash, instance_options)
    end

    # Metadata that can be appended to the root_level of the JSON response
    def meta
      instance_options.fetch(:meta) do
        { status: :success }
      end
    end
  end
end
