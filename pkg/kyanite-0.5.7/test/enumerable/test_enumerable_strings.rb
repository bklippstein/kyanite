# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/enumerable/enumerable_strings'

class Array
  include EnumerableStrings
end


# Tests für EnumerableStrings
# 
class TestKyaniteEnumerableStrings < UnitTest
  
  def test_palindrom_rumpf
    test = ['lut', 'lutr', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr', 'lut']
    assert_equal ['lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri'],  test.palindrom_rumpf
  end  

end # class 
