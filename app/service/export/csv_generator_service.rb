require 'csv'

module Export
  class CsvGeneratorService
    def initialize(data, atributes, class_name)
      @data = data
      @attributes = atributes
      @class_name = class_name
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << attributes

        if data.instance_of?(class_name)
          csv << attributes.map { |attr| data.send(attr) }
        else
          data.all.each do |obj|
            csv << attributes.map { |attr| obj.send(attr) }
          end
        end
      end
    end

    private

    attr_accessor :data, :attributes, :class_name
  end
end
