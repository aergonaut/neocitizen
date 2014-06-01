require 'spec_helper'

describe Neocitizen::Client, :vcr do
  let(:client) { Neocitizen::Client.new username: test_neocitizen_username, password: test_neocitizen_password }

  describe "#info" do
    let(:sitename) { "superteamawesome" }

    subject(:response) { client.info(sitename) }

    it "hits the /api/info endpoint" do
      response
      a_request(:get, "https://neocities.org/api/info").with(query: { sitename: sitename }).should have_been_made
    end

    it "returns the info as a Hash" do
      expect(response).to be_a(Hash)
    end
  end

  describe "#upload" do
    subject(:response) { client.upload(*files) }

    let(:files) { [File.expand_path(File.join("..", "..", "..", "fixtures", "index.html"), __FILE__)] }

    it "hits the /api/upload endpoint" do
      response
      a_request(:post, "https://neocities.org/api/upload").should have_been_made
    end

    it "returns the info as a Hash" do
      expect(response).to be_a(Hash)
    end
  end
end
