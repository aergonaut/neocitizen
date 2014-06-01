require 'thor'
require 'neocitizen/version'

module Neocitizen
  class CLI < Thor
    include Thor::Actions

    desc "site SITENAME", "Creates a skeleton for a Neocities site"
    def site(sitename)
      directory("newsite", sitename)
    end

    def self.source_root
      File.dirname(File.join("..", "..", "..", "templates"), __FILE__)
    end
  end
end
