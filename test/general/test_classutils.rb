# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'transparent_nil'    unless defined? TransparentNil
require 'kyanite/unit_test'
require 'kyanite/general/classutils'


class DummyClass1 # :nodoc:
end
module DummyModule # :nodoc:
  class DummyClass2 # :nodoc:
  end
end



# Tests for String, Symbol, Class
#
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
