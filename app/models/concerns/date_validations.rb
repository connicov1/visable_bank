# frozen_string_literal: true

# DateValidations module that validates date format
module DateValidations
  extend ActiveSupport::Concern

  included do
    validates :date, date_format: true, allow_blank: true
  end
end
