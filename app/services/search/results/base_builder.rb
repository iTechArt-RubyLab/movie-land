module Search
  module Results
    class BaseBuilder
      def initialize(record)
        @record = record
      end

      def autocomplete_hint
        'Not implement yet'
      end

      private

      attr_reader :record
    end
  end
end
