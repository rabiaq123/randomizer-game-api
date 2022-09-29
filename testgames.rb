require "test/unit"
 
class TestSimpleNumber < Test::Unit::TestCase
 
  def test_simple
    puts "donkey test"
    assert_equal(4, 2 * 2 )
    assert_equal(6, 2 * 3 )
  end
 
end
