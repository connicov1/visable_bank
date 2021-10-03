# frozen_string_literal: true

# Creates ApplicationController class
class ApplicationController < ActionController::API
  include ErrorHandling

  # To be used as a fallback for unknown routes
  def route_not_found
    head :not_found
  end
end
