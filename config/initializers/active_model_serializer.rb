# frozen_string_literal: true

# Specify the serialised format for response data.
# See https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/adapters.md
# When none is specified, the default adapter is used.
ActiveModelSerializers.config.adapter = Adapters::JSONWithStatusAdapter
