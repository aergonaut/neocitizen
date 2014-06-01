require 'faraday'
require 'excon'
require 'mimemagic'

module Neocitizen
  class Client
    attr_accessor :options

    # Build a new Neocitizen client.
    #
    # @param [Hash] opts initialization options
    # @option opts [String] :username Neocities username
    # @option opts [String] :password Neocities password
    # @option opts [String] :api_host (https://neocities.org)
    #
    # @return [Hash] JSON from the response
    def initialize(options = {})
      options = {
        username: ENV["NEOCITIZEN_USERNAME"],
        password: ENV["NEOCITIZEN_PASSWORD"]
      }.merge(options)

      raise ArgumentError, "Username and password are required" unless options[:username] && options[:password]

      self.options = options
    end

    # Get info about a Neocities site
    #
    # @example Get info on a site
    #   client.info("cool-site")
    #
    # @param [String] sitename Neocities site to get info about (defaults to the authenticated user)
    #
    # @return [Hash] JSON from the response
    def info(sitename = nil)
      sitename ||= options[:username]
      response = connection.get "/api/info", { sitename: sitename }
      MultiJson.load(response.body)
    end

    # Upload one or more files to Neocities
    #
    # @example Upload files
    #   client.upload("index.html", "cool-graphic.gif")
    #
    # @param [Array] files file names to upload
    #
    # @returns [Hash] JSON from the response
    def upload(*files)
      payload = files.inject({}) do |hash, filename|
        type = MimeMagic.by_path(filename)
        basename = File.basename(filename)
        hash[basename.to_sym] = Faraday::UploadIO.new(filename, type)
        hash
      end

      response = connection.post "/api/upload", payload
      MultiJson.load(response.body)
    end

    private

    def connection
      @connection ||= Faraday.new(url: api_host) do |faraday|
        faraday.request :basic_auth, self.options[:username], self.options[:password]
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter :excon
      end
    end

    def api_host
      self.options[:api_host] || ENV["NEOCITIZEN_API_HOST"] || "https://neocities.org"
    end
  end
end
