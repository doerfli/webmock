class MockRequest
  include Mongoid::Document
  include Mongoid::Timestamps
  include InstanceOps
  include TimeScopes

  belongs_to :mock, dependent: :nullify, counter_cache: true

  field :remote_address, type: String
  field :method, type: String
  field :headers, type: Hash
  field :contenttype, type: String
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

  def query_params_as_text
    return "" if query_params.nil?
    query_params.map{ |k,v| "#{k}: #{v}"}.join("\n")
  end
end