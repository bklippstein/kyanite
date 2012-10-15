# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/general/true_false'


# Tests for TrueClass, FalseClass
class TestKyaniteTrueFalse < UnitTest

  def test_0_und_1
      assert_equal 1,         true.to_i    
      assert_equal 0,         false.to_i      
  end 
  
 
  
  
  def test_raumschiff_operator
      assert_equal 0,         true <=> true
      assert_equal 0,         false <=> false
      assert_equal -1,        false <=> true
      assert_equal 1,         true <=> false
  end  

  

end # class 
