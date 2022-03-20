module Search
  class Autocompleter < ApplicationService
    MODELS_TO_SEARCH = [Movie, Person, ActorRole].freeze

    def initialize(query)
      @query = query
    end

    def call
      results.map do |result|
        {
          hint: result,
          record_type: result.class.name,
          record_id: result.id
        }
      end
    end

    private

    attr_reader :query

    def results
      Elasticsearch::Model.search(search_query,
                                  MODELS_TO_SEARCH).records
    end

    def search_query
      {
        size: 50,
        query: {
          function_score: {
            query: {
              bool: {
                must: [multi_match]
              }
            },
            functions: priorities
          }
        }
      }
    end

    def multi_match
      {
        multi_match: {
          query: query,
          fields: %w[name release_date surname role_name],
          fuzziness: 'auto'
        }
      }
    end

    def priorities
      [
        {
          filter: {
            term: { _type: 'movie' }
          },
          weight: 5000
        }
      ]
    end
  end
end
