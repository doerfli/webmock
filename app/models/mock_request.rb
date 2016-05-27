class MockRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  include InstanceOps

  belongs_to :mock, dependent: :destroy

  field :remote_address, type: String
  field :method, type: String
  field :headers, type: Hash
  field :body, type: String
  field :body_size, type: Fixnum
  field :url, type: String
  field :query_params, type: Hash


  validates :remote_address, presence: true
  validates :method, presence: true

  def created_at_date
    created_at.strftime '%y/%m/%d'
  end

  def created_at_time
    created_at.strftime '%H:%M:%S'
  end

end