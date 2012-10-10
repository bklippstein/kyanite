# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'                   
require 'kyanite/range'           


# Tests for Range
class TestKyaniteRange < UnitTest

  

  def test_invert
  
    # leeres Teil ausgeben
    assert_equal (1..0),              (0..-1).invert_index
    
    # vorderen Teil ausgeben
    assert_equal (0..1),              (2..-1).invert_index
    assert_equal (0..2),              (3..-1).invert_index
    assert_equal (0..-3),             (-2..-1).invert_index
    
    # hinteren Teil ausgeben
    assert_equal (2..-1),             (0..1).invert_index
    assert_equal (6..-1),             (0..5).invert_index
    assert_equal (-1..-1),            (0..-2).invert_index
    assert_equal (-2..-1),            (0..-3).invert_index
 
    # außen
    assert_equal [0..1,   5..-1],     (2..4).invert_index
    assert_equal [0..-6, -2..-1],     (-5..-3).invert_index
    assert_equal [0..1,  -2..-1],     (2..-3).invert_index
    assert_equal [0..-6,  5..-1],     (-5..4).invert_index


  end 
  

  

end # class 
