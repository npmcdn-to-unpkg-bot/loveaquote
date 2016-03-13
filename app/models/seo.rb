class Seo < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  
  validates_uniqueness_of :source_id, scope: :source_type
end
