# ELA Integration Service for G+J ELA Testing.
#
# @version: 0.0.1
# @author: HEUMAIER, Andreas
# (c) 2012 MetaWays InfoSystems GmbH

require 'rubygems'
require 'json'

module Eis
  class OutputHandler

    def initialize()
      get_configs()
      load_config()
    end

    # public api method giving
    # check results back as json
    def render_json
    end

    # public api method giving
    # check results back as xml
    def render_xml
    end

  end
end