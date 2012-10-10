# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/matrix2'
require 'kyanite/general/nil'   

# require 'benchmark'
# include Benchmark


# Tests for Matrix2
class TestKyaniteMatrix2 < UnitTest


  #
  # Normale Matrix testen: Zellen und Zeilen
  #
  def test_matrix_zellen_und_zeilen
  # Initialisierung
  zeile0 = ['Ueberschrift', 'Spalte1', 'Spalte2']
  zeile1 = ['Zeile1', 'Wert 1.1', 'Wert 1.2']
  zeile2 = ['Zeile2', 'Wert 2.1', 'Wert 2.2']
  zeile3 = ['Zeile3', 'Wert 3.1', 'Wert 3.2', 'Wert 3.3']
  zeile4 = ['Zeile4', 'Wert 4.1', 'Wert 4.2']

  table = [zeile0, zeile1, zeile2, zeile3, zeile4]    # dies ist noch ein Array
  mymatrix = Matrix2.new(table)                       # und dies ist eine Matrix2
  assert_kind_of Matrix2, mymatrix
   
  
  # Zellen-Funktionen testen
  assert_equal 'Wert 2.2',      mymatrix[2][2]
  mymatrix.set_element!(2,2,'Hallo 2.2')
  assert_equal 'Hallo 2.2',     mymatrix[2][2]
  

  #  Zeilen-Funktionen testen
  assert_equal 	zeile2,                   mymatrix.row(2)
  assert_equal 	mymatrix.row(2).size,     mymatrix.column_size	   
  assert_nil                              mymatrix.row(99)
  assert_nil                              mymatrix.row(-99)
  assert_equal 	0,                        mymatrix.row(99).size
  mymatrix.set_row!(3, zeile4)  
  assert_equal	mymatrix.row(3),          mymatrix.row(4)
  mymatrix[3][0] = 'Z3'	
  mymatrix.set_element!(3,0,'ZEILE3')	
  mymatrix.set_element!(3,1,'WERT 3.1')	
  mymatrix.set_element!(3,2,'WERT 3.2')	
  assert_not_equal mymatrix.row(3),       mymatrix.row(4)
  
  zeile5 = ['Zeile5', 'Wert 5.1', 'Wert 5.2']
  mymatrix.set_row!(5, zeile5)  	
  end




  # 
  # Normale Matrix testen: resize_to_header
  #	
  def test_resize_to_header
  # Erneute Initialisierung
  zeile0 = ['Ueberschrift', 'Spalte1', 'Spalte2']
  zeile1 = ['Zeile1', 'Wert 1.1', 'Wert 1.2']
  zeile2 = ['Zeile2', 'Wert 2.1']
  zeile3 = ['Zeile3', 'Wert 3.1', 'Wert 3.2', 'Wert 3.3']
  zeile4 = ['Zeile4', 'Wert 4.1', 'Wert 4.2']
  zeile5 = ['Zeile5']
  mymatrix = Matrix2.new([zeile0, zeile1, zeile2, zeile3, zeile4, zeile5])	

  
  # clean4view(0) testen -- Resize to header 
  assert_equal 16,            mymatrix.flatten.size
  assert_equal 18,            mymatrix.clean4view(0).flatten.size
  assert_equal 16,            mymatrix.flatten.size	
  mymatrix.clean4view!(0)
  assert_equal 18,            mymatrix.flatten.size		
  assert_equal 18,            mymatrix.clean4view(0).flatten.size
  assert_kind_of Matrix2,     mymatrix.clean4view(0)	
  mymatrix.clean4view!
  assert_kind_of Matrix2,     mymatrix   
  end
  
  
  
  
  # 
  # Normale Matrix testen: Spalten
  #	
  def test_spalten
  # Erneute Initialisierung
  zeile0 = ['Ueberschrift', 'Spalte1', 'Spalte2']
  zeile1 = ['Zeile1', 'Wert 1.1', 'Wert 1.2']
  zeile2 = ['Zeile2', 'Wert 2.1']
  zeile3 = ['Zeile3', 'Wert 3.1', 'Wert 3.2', 'Wert 3.3']
  zeile4 = ['Zeile4', 'Wert 4.1', 'Wert 4.2']
  zeile5 = ['Zeile5']
  mymatrix = Matrix2.new([zeile0, zeile1, zeile2, zeile3, zeile4, zeile5])		
  
  #  Spalten-Funktionen testen
  assert_equal 	mymatrix.column(2).size,            mymatrix.row_size
  assert_nil                                        mymatrix.column(99)
  assert_nil                                        mymatrix.column(-99)
  assert_equal 	0,                                  mymatrix.column(99).size	
  spalte2 = mymatrix.column(2)
  mymatrix.set_column!(3, spalte2)
  mymatrix.set_column!(4, spalte2)
  assert_equal 	mymatrix.column(2),                 mymatrix.column(3)
  assert_equal 	mymatrix.column(2),                 mymatrix.column(4)
  assert_equal 30,                                  mymatrix.flatten.size
  end

  
  
  # 
  # Matrix mit Fehlern testen
  #	
  def test_fehlerhalte_matrix
  # Erneute Initialisierung
  zeile0 = ['X', 'Spalte1', nil, 'Spalte3']
  zeile1 = [ nil, 'Wert 1.1', 'Wert 1.2','Wert 1.3']
  zeile2 = []
  zeile3 = nil
  zeile4 = ['Zeile4', 'Wert 4.1', 'Wert 4.2']	
  zeile5 = [ nil , nil, nil, nil, nil, nil, nil, nil]
  zeile6 = ['Zeile6', nil, 'Wert 6.2', 'Wert 6.3']	
  zeile7 = ['Zeile7', 'Wert 7.1', 'Wert 7.2', 'Wert 7.3']	
  zeile8 = ['Zeile8', 'Wert 8.1', nil, 'Wert 8.3']	
  zeile9 = ['Zeile9', 'Wert 9.1', nil, 'Wert 9.3', 'Wert 9.4']	

  
  assert_not_nil 	          zeile0.row_to_nil
  assert_nil 		            zeile1.row_to_nil
  assert_nil 		            zeile2.row_to_nil
  assert_nil 		            zeile3.row_to_nil
  assert_not_nil 	          zeile4.row_to_nil
  assert_nil 		            zeile5.row_to_nil	
  assert_not_nil 	          zeile6.row_to_nil	
  
  
  errormatrix = Matrix2.new([zeile0, zeile1, zeile2, zeile3, zeile4, zeile5, zeile6, zeile7, zeile8, zeile9])								
  

  # assert_equal 37,          errormatrix.flatten.size
  # assert_equal 40,          errormatrix.clean4view(0).flatten.size
  # assert_equal 24,          errormatrix.clean4view(1).flatten.size
  # assert_equal 18,          errormatrix.clean4view(2).flatten.size

  end

  








end # class 
