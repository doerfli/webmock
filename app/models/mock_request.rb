class MockRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :mock, dependent: :destroy

  field :remote_address, type: String
  field :method, type: String
  field :headers, type: Hash
  field :body, type: String

  validates :remote_address, presence: true
  validates :method, presence: true
end