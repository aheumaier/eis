# ELA Integration Service for G+J ELA Testing.
#
# @version: 0.0.1
# @author: HEUMAIER, Andreas
# (c) 2012 MetaWays InfoSystems GmbH

require 'socket'
require 'yaml'

Dir['./*.rb'].each {|lib| puts "require "; require_relative lib }
Dir['../modules/*.rb'].each do |file|
  puts "File is " + file.to_s
  require_relative file;
  include self.class.const_get(File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.to_s)
  puts "loaded  " + self.class.const_get(File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.to_s)
end

module Eis
  class Runner

    class << self
      attr_accessor :module_result_states
    end

    # class adapter for merging all module results in a common pool
    #
    def self.set_module_result_states(key, val)
      if self.module_result_states.nil?
        @module_result_states = {key => val}
      else
        @module_result_states.store(key, val)
      end
    end

    attr_reader :env, :subdomain
    attr_accessor :nodes, :loaded_modules, :config


    # basic integration-check constructor:
    # build up the test scenario while loading
    # all modules from ./modules and parsing
    # configuration files - config.yml is default
    # ==== Examples
    #  it = Base.new
    #
    def initialize()
      begin
        puts "Eis::Runner::init called"
        @loaded_modules = []
        generate_module_list()
        handle = InputHandler.new()
        set_environment()
      rescue ArgumentError =>e
        puts "\e[31mERROR\e[0m: No config file given..." + e
        puts "--------------------------------------------"
        raise
      end
    end

    public
    # generic iterator:
    # runs all test defined in given modules
    # based on its given data set
    # ==== Examples
    #  it = Runner.run_tests
    #
    def run_tests()
      @loaded_modules.each do |module_name|
        module_class = Object.const_get(module_name.to_s).const_get(module_name.to_s).new
        if module_class.respond_to?( 'run' )
          module_class.run()
        else
          puts "\e[31mWARNING\e[0m: Module #{(module_name)} not implemented"
        end
      end
    end

    private
    #
    #
    def generate_module_list
      puts "Eis::Runner::gen_module_list called"
      Dir["modules/*.rb"].each {|file|
        puts "Error: No modules loaded"; exit 1 if loaded_modules.first.nil?
        @loaded_modules << self.class.const_get(
            File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.to_s
        )}
    end

    #
    #
    def set_environment()
      case get_domainname
        when /webcloud/
          @env = 'live'
          @subdomain = ''
        when /webstage/
          @env = 'stage'
          @subdomain = 'stage.'
        when /webdev/
          @env = 'dev'
          @subdomain = 'dev.'
        else
          puts "\e[31mWARNING\e[0m: Bad Host Domain"
          @env = 'localhost'
          @subdomain = 'localhost'
      end
    end

    #
    #
    def get_domainname(domainstring='')
      Socket.gethostname.split(".")[1..-1].each { |s|domainstring << "#{s}." }
      return domainstring.chop
    end

  end # end class Eis::Runner
end # end Namspace Eis