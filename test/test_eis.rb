require 'helper'

class TestEis < Test::Unit::TestCase

  def test_eis_init
    assert_nothing_raised do
      runner = Eis::Runner.new()
      # raise Exception #Assertion fails
    end
    runner = Eis::Runner.new()
  end


end
