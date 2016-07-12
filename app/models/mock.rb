class Mock
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :mock_requests, dependent: :destroy

  before_destroy { |mock| mock.mock_requests.delete_all }

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

  def remove_empty_headers
    return if self.customheaders.nil?
    self.customheaders = self.customheaders.select{ |x| true if !( x[:name].nil? ) && ! ( x[:name].eql?('') ) && ! ( x[:value].nil? ) && ! ( x[:value].eql?('') ) }
  end

  def body_pp
    body_pretty_print
  end
end