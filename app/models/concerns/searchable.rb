module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    scope :by_query, -> query { search(query).records }

    index_name 'admin-with-mongo'
    document_type "#{to_s.pluralize.underscore.dasherize}"

    def as_indexed_json(_ = {})
      as_json(except: [:id, :_id, :coords])
    end
  end
end
