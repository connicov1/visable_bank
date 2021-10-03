# frozen_string_literal: true

# Module to rescue from any catched errors and render them in RESTful JSON format
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_exception
  end

  private

  # Renders an exception JSON object
  def render_exception(exception)
    @exception = exception

    api_result_exception = handle_exception_error

    render json: api_result_exception.attributes, status: api_result_exception.http_status
  end

  # Finds and builds a corresponding error
  #
  # @return [Errors::ActiveRecordApiException, Errors::BadRequestException]
  def handle_exception_error
    case @exception
    when ActiveRecord::RecordInvalid
      build_activerecord_exception
    else
      build_bad_request_exception
    end
  end

  # Builds an ActiveRecordApiException error
  #
  # @return [Errors::ActiveRecordApiException]
  def build_activerecord_exception
    record         = @exception.record
    error_code     = "#{record.class.name.remove('::').underscore}_is_invalid"
    error_messages = record.errors.messages

    Errors::ActiveRecordApiException.new(
      http_status: :unprocessable_entity,
      error_code: error_code,
      error_reason: error_messages,
      attribute: nil,
      status: :failed
    )
  end

  # Builds a BadRequestException error
  #
  # @return [Errors::BadRequestException]
  def build_bad_request_exception
    Errors::BadRequestException.new(
      http_status: :bad_request,
      error_reason: @exception.message
    )
  end
end
