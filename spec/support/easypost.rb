# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    SolidusEasypost.configure do |c|
      c.api_key = 'CvzYtuda6KRI9JjG7SAHbA'
    end
  end
end
