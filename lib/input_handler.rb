# ELA Integration Service for G+J ELA Testing.
#
# @version: 0.0.1
# @author: HEUMAIER, Andreas
# (c) 2012 MetaWays InfoSystems GmbH

require 'rubygems'
require 'json'
require 'yaml'
require "net/https"
require "uri"

module Eis
  class InputHandler
    attr_accessor :config_file

    def initialize()
      puts "EIS::InputHander initialize"
      get_configs()
      load_config()
    end

    def self.hostnames
      @@hostnames
    end

    private
    # private api method:
    # find all *.yml/*.json config files and load the ones first found
    def get_configs()
      config_pool = Dir.glob("*.yml")
      if  config_pool.empty?
        config_pool = Dir.glob("*.json") unless
            if config_pool.empty?
              puts "\e[33mINFO\e[0m: No local config found! Using test/content/config.yml..."
              self.config_file=('test/content/config.yml')
            end
      else
        self.config_file=(config_pool.first)
      end
    end

    # private api method:
    # *.yml/*.jso dependent of file ext n config files
    def load_config()
      case File.exist?(self.config_file)
        when File.extname(self.config_file) == ".yml"
          @@hostnames = begin
            YAML.load( File.open(self.config_file) )
          rescue ArgumentError => e
            puts "Could not parse YAML: #{e.message}"
          end
        when File.extname(self.config_file) == ".json"
          @@hostnames = begin
            JSON.parse( File.open(self.config_file))
          rescue ArgumentError => e
            puts "Could not parse JSON: #{e.message}"
          end
        else
          puts "\e[31mERROR\e[0m: No matching config-File found..."
          puts "--------------------------------------------"
          exit 1
      end
    end

    def load_url(uri)
      uri = URI.parse(uri) || URI.parse("http://api.twitter.com/1/statuses/public_timeline.json")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      @@hostnames = JSON.parse(res.body)
    end

  end
end