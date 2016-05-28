class Mock
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :mock_requests, dependent: :destroy

  field :statuscode, type: Numeric, default: "200"
  field :contenttype, type: String, default: "application/json"
  field :customheaders, type: Array
  field :body, type: String, default: ''

  validates :statuscode, presence: true
  validates_numericality_of :statuscode, greater_than_or_equal_to: 100, less_than: 600
  validates :contenttype, presence: true

  MIME_TYPES = %w(
      application/json
      application/xml
      application/x-www-form-urlencoded
      multipart/form-data
      text/html
      text/xml
      text/css
      text/csv
      text/plain
  )

  def latest_requests(num = 16)
    mock_requests.order_by(:created_at => 'desc').limit(num).map{|r|
      r.only_members(
          :_id,
          :method,
          :url,
          :query_params_as_text,
          :created_at,
          :remote_address,
          :created_at_date,
          :created_at_time,
          :headers,
          :body,
          :body_size,
      )
    }
  end

  def remove_empty_headers
    self.customheaders = self.customheaders.select{ |x| true if !( x[:name].nil? ) && ! ( x[:name].eql?('') ) && ! ( x[:value].nil? ) && ! ( x[:value].eql?('') ) }
  end
end