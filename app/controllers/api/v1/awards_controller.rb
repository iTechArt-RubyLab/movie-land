module Api
  module V1
    class AwardsController < ApplicationController
      before_action :set_award, only: %i[show update destroy]

      def index
        @awards = Dictionary::FindService.new(Award, params).call

        render json: @awards, each_serializer: AwardSerializer
      end

      def show
        render json: @award, serializer: AwardSerializer
      end

      def create
        @award = Award.new(award_params)

        if @award.save
          render json: @award, status: :created, serializer: AwardSerializer
        else
          render json: @award.errors, status: :unprocessable_entity
        end
      end

      def update
        if @award.update(award_params)
          render json: @award, serializer: AwardSerializer
        else
          render json: @award.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @award.destroy
      end

      private

      def set_award
        @award = Award.find(params[:id])
      end

      def award_params
        params.require(:award).permit(:name, :country_id)
      end
    end
  end
end
