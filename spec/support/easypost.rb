# frozen_string_literal: true

RSpec.configure do |config|
  config.before {
    SolidusEasypost.configure do |config|
      config.api_key = 'CvzYtuda6KRI9JjG7SAHbA'
    end
  }
end
