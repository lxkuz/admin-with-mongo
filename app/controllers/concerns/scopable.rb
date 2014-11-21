module Scopable
  extend ActiveSupport::Concern

  included do
    has_scope :by_query, as: :query
    has_scope :order_by, type: :hash
  end
end
