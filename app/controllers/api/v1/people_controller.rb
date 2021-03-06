module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_person, only: %i[show update destroy]
      before_action :authorize_person!
      after_action :verify_authorized

      def index
        @people = People::FindService.call(params)

        render json: @people, each_serializer: PersonSerializer
      end

      def show
        render json: @person, serializer: PersonSerializer
      end

      def create
        @person = Person.new(person_params)

        if @person.save
          render json: @person, status: :created, serializer: PersonSerializer
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      def update
        if @person.update(person_params)
          render json: @person, serializer: PersonSerializer
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @person.destroy
      end

      private

      def set_person
        @person = Person.find(params[:id])
      end

      def person_params
        params.require(:person).permit(%i[name surname birthday deathday married country_id])
      end

      def authorize_person!
        authorize(@person || Person)
      end
    end
  end
end
