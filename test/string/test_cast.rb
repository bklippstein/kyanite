# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/string/cast'



# Tests for String
# @!macro string
class TestKyaniteStringCast < UnitTest

  def test_to_nil
  	assert_equal 'e', 'e'.to_nil
  	assert_equal nil, ''.to_nil    
  	assert_equal nil, nil.to_nil
  end
  
    
   def test_to_integer
  	assert_equal nil, "Hallo".to_integer
  	assert_equal 0, "Hallo0".to_integer
  	assert_equal 0, "0Hallo".to_integer
  	assert_equal nil, "".to_integer
  	assert_equal nil, nil.to_integer
  	assert_equal 23, 23.to_integer

  	# macht alles noch die alte Funktion to_i
  	assert_equal 123, "123Hallo2".to_integer
  	assert_equal 123, "123 Hallo2".to_integer
  	assert_equal 123, " 123 Hällo2".to_integer
  	assert_equal -123, " -123 Hallo2".to_integer
  	assert_equal -1, " -1,23 Hallo2".to_integer

  	# jetzt kommt die neue Funktionalität zum Zuge
  	assert_equal 42, "Hallo42".to_integer
  	assert_equal 42, "Hallo42JoJo".to_integer
  	assert_equal 42, " Hällo-42".to_integer
  	assert_equal 42, "Hallo42.1".to_integer	
  	assert_equal 42, "Hallo42,1".to_integer	
  end  

    
	
  def test_to_integer_optional	
  	assert_equal "Hallo", "Hallo".to_integer_optional
  	assert_equal "Hallo0", "Hallo0".to_integer_optional
  	assert_equal 0, "0Hallo".to_integer_optional
  	assert_equal nil, "".to_integer_optional
  	assert_equal nil, nil.to_integer_optional
  	assert_equal 23, 23.to_integer_optional

  	assert_equal 123, "123Hallo2".to_integer_optional
  	assert_equal 123, "123 Hallo2".to_integer_optional
  	assert_equal " 123 Hällo2", " 123 Hällo2".to_integer_optional   # Spaces am Anfang sind nicht erlaubt
  	assert_equal -123, "-123 Hallo2".to_integer_optional
  	assert_equal -1, "-1,23 Hallo2".to_integer_optional
  	assert_equal "Hallo42", "Hallo42".to_integer_optional
  end   
  
  
  
  def test_to_identifier
    assert_equal 1,           '1'.to_identifier
    assert_equal 2,           '   2'.to_identifier
    assert_equal 3,           '   3    '.to_identifier
    assert_equal 4,           '4    '.to_identifier
    assert_equal 'a',         'a    '.to_identifier
    assert_equal 'b',         ' b    '.to_identifier
    assert_equal 'c',         '    c'.to_identifier
    assert_equal 'hallo123',  '    hallo123 '.to_identifier
    assert_equal 123,         '    123hallo '.to_identifier
    assert_equal 123,         '    123hallo456  '.to_identifier
  end
    
    
    
end # class

































