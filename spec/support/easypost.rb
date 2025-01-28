# frozen_string_literal: true

RSpec.configure do |config|
  config.before { easypost_client }
end

def easypost_client
  EasyPost::Client.new(api_key: 'CvzYtuda6KRI9JjG7SAHbA')
end

