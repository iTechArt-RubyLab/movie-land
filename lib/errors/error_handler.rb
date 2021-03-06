module Errors
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |error|
          respond(:standard_error, 500, error.to_s)
        end

        rescue_from ArgumentError do |error|
          respond(:argument_error, 404, error.to_s)
        end

        rescue_from ActionController::ParameterMissing do |error|
          respond(:parameter_missing, 400, error.to_s)
        end

        rescue_from ActiveRecord::RecordNotFound do |error|
          respond(:record_not_found, 404, error.to_s)
        end

        rescue_from ActiveRecord::RecordInvalid do |error|
          respond(:record_invalid, 422, error.to_s)
        end

        rescue_from ActiveRecord::RecordNotSaved do |error|
          respond(:record_not_saved, 422, error.to_s)
        end

        rescue_from ActiveRecord::RecordNotDestroyed do |error|
          respond(:record_not_destroyed, 422, error.to_s)
        end

        rescue_from ActiveRecord::RecordNotUnique do |error|
          respond(:record_not_unique, 422, error.to_s)
        end

        rescue_from ActiveRecord::InvalidForeignKey do |error|
          respond(:invalid_foreign_key, 422, error.to_s)
        end

        rescue_from ActiveRecord::MismatchedForeignKey do |error|
          respond(:mismatched_foreign_key, 422, error.to_s)
        end

        rescue_from ActiveModel::UnknownAttributeError do |error|
          respond(:unknown_attribute_error, 422, error.to_s)
        end

        rescue_from ActiveModel::StrictValidationFailed do |error|
          respond(:strict_validation_failed, 422, error.to_s)
        end

        rescue_from ActiveModel::RangeError do |error|
          respond(:range_error, 422, error.to_s)
        end

        rescue_from AASM::UndefinedState do |error|
          respond(:undefined_state, 422, error.to_s)
        end

        rescue_from AASM::InvalidTransition do |error|
          respond(:invalid_transition, 422, error.to_s)
        end

        rescue_from Pundit::NotAuthorizedError do
          respond(:not_authorized, 401, 'You are not authorized to perform this action!')
        end
      end
    end

    private

    def respond(error, status, message)
      json = Helpers::Render.json(error, status, message)
      render json: json, status: status
    end
  end
end
