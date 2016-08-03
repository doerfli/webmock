require 'active_support/concern'

module TimeScopes
  extend ActiveSupport::Concern

  included do
    scope :created_today, -> { where(:created_at.gte => Date.today ) }
    scope :created_last_week, -> { where(:created_at.gte => Date.today - 7.days) }
    scope :created_last_4_weeks, ->  { where(:created_at.gte => Date.today - 4.weeks) }
  end

end