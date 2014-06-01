require 'spec_helper'

describe Neocitizen::Client, :vcr do
  let(:client) { Neocitizen::Client.new username: test_neocitizen_username, password: test_neocitizen_password }

  describe "#info" do
    subject(:response) { client.info("superteamawesome") }

    it "returns the info as a Hash" do
      expect(response).to be_a(Hash)
    end
  end
end
