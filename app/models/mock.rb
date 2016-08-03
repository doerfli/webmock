class Mock
  include Mongoid::Document
  include Mongoid::Timestamps
  include TimeScopes

  has_many :mock_requests, dependent: :destroy

  before_validation { |mock| normalize_blank_values mock }
  before_destroy { |mock| mock.mock_requests.delete_all }

  field :statuscode, type: Numeric, default: "200"
  field :contenttype, type: String, default: "application/json"
  field :customheaders, type: Array
  field :body, type: String, default: ''
  field :created_by_session, type: String
  field :delay, type: Numeric
  field :charset, type: String
  field :mock_requests_count, type: Fixnum, default: 0

  validates :statuscode, presence: true
  validates_numericality_of :statuscode, greater_than_or_equal_to: 100, less_than: 600
  validates :contenttype, presence: true

  scope :created_last_hour, ->(session) { where(created_by_session: session, :created_at.gte => Time.now - 1.hour)}
  scope :by_requests_size, -> { order(requests_count: :desc) }

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


  def body_pp
    body_pretty_print
  end

  def normalize_blank_values(mock)
    mock.delay = nil if ! ( mock.delay.nil? ) && mock.delay == 0
    mock.charset = nil if ! ( mock.charset.nil? ) && mock.charset.empty?
    remove_empty_headers mock
  end

  def remove_empty_headers( mock)
    return if mock.customheaders.nil?
    mock.customheaders = mock.customheaders.select{ |x| true if !( x[:name].nil? ) && ! ( x[:name].eql?('') ) && ! ( x[:value].nil? ) && ! ( x[:value].eql?('') ) }
    mock.customheaders = nil if mock.customheaders.size == 0
  end
end