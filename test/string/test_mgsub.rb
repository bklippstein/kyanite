# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/string/mgsub'



# Tests for String
#
class TestKyaniteStringMgsub < UnitTest

  def test_mgsub
  	assert_equal 'bEtwAAn', 'between'.mgsub([[/ee/, 'AA'], [/e/, 'E']])  
  end
  
    
    
    
    
end # class

































