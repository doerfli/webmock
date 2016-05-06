class Mock
  include Mongoid::Document

  field :statuscode, type: Numeric, default: "200"
  field :contenttype, type: String, default: "application/json"
  field :body, type: String, default: ''

  validates :statuscode, presence: true
  validates_numericality_of :statuscode, greater_than_or_equal_to: 100, less_than: 600
  validates :contenttype, presence: true
end