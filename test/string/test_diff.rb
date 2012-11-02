# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/string/diff'


# Tests for String
# @!macro string
class TestKyaniteStringDiff < UnitTest
    
  def test_overlap	
  	assert_equal "Hallo", 	"Hallo".overlap("Hallo Welt") 
  	assert_equal "Hallo", 	"Hallo Welt".overlap("Hallo")
  	assert_equal "Hallo ", 	"Hallo Du".overlap("Hallo Welt") 
  	assert_equal "Hällo ", 	"Hällo Du".overlap("Hällo Welt") 
  	assert_equal "", 		"qH1allo Du".overlap("Hallo Welt") 
  	assert_equal "q", 		"q# Dum Dum".overlap("q- Dam Dam") 
  	assert_equal "",  		"GoBiLoooo".overlap(nil)
  	assert_equal "",  		"Hoa!".overlap('')
  	assert_equal "",  		"".overlap(nil)
  	assert_equal "",  		"".overlap('')
  	# assert_equal "",  		nil.overlap('')
  	# assert_equal "",  		nil.overlap('Ho')
  end
  
  
  	
  def test_diff    
  	assert_equal " Welt", 		"Hallo".diff("Hallo Welt") 
  	assert_equal " Welt", 		"Hallo Welt".diff("Hallo")
  	assert_equal "Welt", 	 	"Hallo Du".diff("Hallo Welt") 
  	assert_equal "Welt", 	 	"Hällo Du".diff("Hällo Welt") 
  	assert_equal "qH1allo Du", 	"qH1allo Du".diff("Hallo Welt") 
  	assert_equal "# Dum Dum", 	"q# Dum Dum".diff("q- Dam Dam") 
  	assert_equal "GoBuuuoooo", 	"GoBuuuoooo".diff(nil)
  	assert_equal "Hoa!", 		"Hoa!".diff('')
  	assert_equal "", 			"".diff(nil)	
  	assert_equal "", 			"".diff('')	
  	assert_equal "",  			nil.diff('')
  	assert_equal "Ho",  		nil.diff('Ho')
  end	

  
  def test_overlapdiff    
  	a, b = "Hallo".overlapdiff("Hallo Welt"); 				assert_equal "Hallo Welt", a + b
  	a, b = "Hallo Welt".overlapdiff("Hallo"); 				assert_equal "Hallo Welt", a + b
  	a, b = "Hallo Du".overlapdiff("Hallo Welt"); 			assert_equal "Hallo Welt", a + b 
  	a, b = "Hällo Du".overlapdiff("Hällo Welt"); 			assert_equal "Hällo Welt", a + b 
  	a, b = "qH1allo Du".overlapdiff("Hallo Welt"); 			assert_equal "qH1allo Du", a + b 
  	a, b = "q# Dum Dum".overlapdiff("q- Dam Dam"); 			assert_equal "q# Dum Dum", a + b 
  	a, b = "GoBuuuoooo".overlapdiff(nil); 					assert_equal "GoBuuuoooo", a + b
  	a, b = "".overlapdiff(nil); 							assert_equal "", a + b
  	a, b = "".overlapdiff(''); 								assert_equal "", a + b
  	a, b = nil.overlapdiff(''); 							assert_equal "", a + b
  	a, b = nil.overlapdiff('Ho'); 							assert_equal "Ho", a + b
	end

  

  
    
    
end # class

































