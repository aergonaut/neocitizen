require 'faraday'
require 'excon'
require 'mimemagic'

module Neocitizen
  class Client
    attr_accessor :options

    # Public: Build a new Neocitizen client
    #
    # options - Hash of options
    #           :username - Neocities username (required)
    #           :password - Neocities password (required)
    #           :api_host - Neocities API host (default: https://neocities.org)
    #
    # Returns a new Neocitizen::Client
    def initialize(options = {})
      options = {
        username: ENV["NEOCITIZEN_USERNAME"],
        password: ENV["NEOCITIZEN_PASSWORD"]
      }.merge(options)

      raise ArgumentError, "Username and password are required" unless options[:username] && options[:password]

      self.options = options
    end

    # Public: Get info about a single site
    #
    # sitename - the site to check (defaults to authenticated user)
    #
    # Returns a Hash of the site info
    def info(sitename = nil)
      sitename ||= options[:username]
      response = connection.get "/api/info", { sitename: sitename }
      MultiJson.load(response.body)
    end

    # Public: Upload files to Neocities
    #
    # files - Zero or more filenames to upload
    #
    # Examples
    #
    #   client.upload("index.html", "sweet_graphic.gif")
    #
    # Returns nothing
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
