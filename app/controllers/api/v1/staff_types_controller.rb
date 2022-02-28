module Api
  module V1
    class StaffTypesController < ApplicationController
      before_action :set_staff_type, only: %i[update destroy]

      def index
        @staff_types = Dictionary::FindService.new(StaffType, params).call

        render json: @staff_types, each_serializer: DictionarySerializer
      end

      def create
        @staff_type = StaffType.new(staff_type_params)

        if @staff_type.save
          render json: @staff_type, status: :created, serializer: DictionarySerializer
        else
          render json: @staff_type.errors, status: :unprocessable_entity
        end
      end

      def update
        if @staff_type.update(staff_type_params)
          render json: @staff_type, serializer: DictionarySerializer
        else
          render json: @staff_type.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @staff_type.destroy
      end

      private

      def set_staff_type
        @staff_type = StaffType.find(params[:id])
      end

      def staff_type_params
        params.require(:staff_type).permit(%i[name])
      end
    end
  end
end
