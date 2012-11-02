# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'               
require 'kyanite/range'           


# @!macro range
class TestKyaniteRange < UnitTest

  

  def test_invert
  
    # return empty
    assert_equal (1..0),              (0..-1).invert_index
    
    # return front 
    assert_equal (0..1),              (2..-1).invert_index
    assert_equal (0..2),              (3..-1).invert_index
    assert_equal (0..-3),             (-2..-1).invert_index
    
    # return back 
    assert_equal (2..-1),             (0..1).invert_index
    assert_equal (6..-1),             (0..5).invert_index
    assert_equal (-1..-1),            (0..-2).invert_index
    assert_equal (-2..-1),            (0..-3).invert_index
 
    # return outer
    assert_equal [0..1,   5..-1],     (2..4).invert_index
    assert_equal [0..-6, -2..-1],     (-5..-3).invert_index
    assert_equal [0..1,  -2..-1],     (2..-3).invert_index
    assert_equal [0..-6,  5..-1],     (-5..4).invert_index


  end 
  

  

end # class 
