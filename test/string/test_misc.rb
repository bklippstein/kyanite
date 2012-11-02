# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/string/misc'



# Tests for String
# @!macro string
class TestKyaniteStringMisc < UnitTest

  def test_mgsub
  	assert_equal 'bEtwIIn', 'between'.mgsub([[/ee/, 'II'], [/e/, 'E']])  
  	assert_equal 'Hallo', 'Hallo'.mgsub([])  
  end
  
    
    
    
    
end # class

































