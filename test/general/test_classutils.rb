# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'transparent_nil'    unless defined? TransparentNil
require 'kyanite/general/classutils'

# @private
class DummyClass1 
end
# @private
module DummyModule 
  class DummyClass2 # :nodoc:
  end
end


# @!group Class Utils

# @!macro class_utils
class TestKyaniteClassutils < UnitTest

  def test_to_class
    assert_equal DummyClass1,               'DummyClass1'.to_class
    assert_equal DummyClass1,               'dummy_class1'.to_class
    assert_equal DummyClass1,               :DummyClass1.to_class
    assert_equal DummyClass1,               :dummy_class1.to_class
    assert_equal DummyClass1,               DummyClass1.to_class
    assert_equal DummyModule::DummyClass2,  'DummyModule::DummyClass2'.to_class
    
    assert_equal nil,                       'DummyClass2'.to_class
    assert_equal nil,                       'UserBlaBlubb'.to_class
    assert_equal nil,                       'user_bla_blubb'.to_class
    assert_equal nil,                       nil.to_class
  end  
  
  
  def test_to_classname
    assert_equal 'dummy_class1',            'DummyClass1'.to_classname
    assert_equal 'dummy_class2',            'DummyModule::DummyClass2'.to_classname

    assert_equal 'dummy_class1',            DummyClass1.to_classname
    assert_equal 'dummy_class2',            DummyModule::DummyClass2.to_classname
	
    assert_equal '',                        nil.to_classname      
  end

  

end # class 
