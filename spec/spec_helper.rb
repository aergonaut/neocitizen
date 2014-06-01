require 'rspec'
require 'vcr'
require 'webmock/rspec'
require 'neocitizen'
require 'base64'

RSpec.configure do |rspec|
  rspec.treat_symbols_as_metadata_keys_with_true_values = true
end

WebMock.disable_net_connect!

VCR.configure do |vcr|
  vcr.configure_rspec_metadata!
  vcr.cassette_library_dir = "spec/cassettes"
  vcr.hook_into :webmock

  vcr.default_cassette_options = {
    serialize_with: :json,
    decode_compressed_response: true,
    record: ENV["TRAVIS"] ? :none : :once
  }

  vcr.filter_sensitive_data("<NEOCITIZEN_USERNAME>") do
    test_neocitizen_username
  end

  vcr.filter_sensitive_data("<NEOCITIZEN_PASSWORD>") do
    test_neocitizen_password
  end

  vcr.filter_sensitive_data("<NEOCITIZEN_BASIC_AUTH>") do
    Base64.strict_encode64("#{test_neocitizen_username}:#{test_neocitizen_password}")
  end
end

def test_neocitizen_username
  ENV["NEOCITIZEN_TEST_USERNAME"]
end

def test_neocitizen_password
  ENV["NEOCITIZEN_TEST_PASSWORD"]
end
