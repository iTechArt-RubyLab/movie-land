module Api
  module V1
    class PersonReportsController < ApplicationController
      before_action :authorize_person_report!
      after_action :verify_authorized

      def index
        @people = Person.all

        respond_to do |format|
          format.csv do
            send_data Export::CsvGeneratorService.new(@people, PERSON_COLUMNS, Person).to_csv,
                      filename: 'people.csv'
          end
        end
      end

      def show
        @person = Person.find(params[:person_id])

        respond_to do |format|
          format.csv do
            send_data Export::CsvGeneratorService.new(@person, PERSON_COLUMNS, Person).to_csv,
                      filename: "#{params[:person_id]}_person.csv"
          end
        end
      end

      private

      PERSON_COLUMNS = %w[id name surname married birthday deathday].freeze

      def authorize_person_report!
        authorize(@person || Person)
      end
    end
  end
end
