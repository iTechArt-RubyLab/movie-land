module Search
  module Results
    class HintBuilder
      def initialize(record)
        @record = record
      end

      def self.call(record)
        new(record).call
      end

      def call
        result_builder.autocomplete_hint
      end

      private

      attr_accessor :record

      def result_builder
        "Search::Results::#{@record.class.to_s.pluralize}::Builder".constantize.new(@record)
      end
    end
  end
end
