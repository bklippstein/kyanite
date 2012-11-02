# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/enumerable/enumerable_strings'




# @!macro enum_of_strings
class TestKyaniteEnumerableStrings < UnitTest
  
  def test_palindrom_rumpf
    test = ['lut', 'lutr', 'lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri', 'lutr', 'lut'].to_array_of_strings
    result = ['lutmi', 'lutmil', 'lutmila', 'lutrika', 'lutrik', 'lutri'].to_array_of_strings
    assert_equal result,  test.palindrom_rumpf
  end  

end # class 
