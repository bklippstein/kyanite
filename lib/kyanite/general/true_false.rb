# ruby encoding: utf-8
# [ | *Kyanite* | Object | Array | Set | Enumerable | Hash | ]    | Kyanite | *TrueClass* | FalseClass | NilClass | Div | 
#
# ---
#
# == *True*
#
#
class TrueClass  
     
     
  # Rückgabe: 1     
  def to_i; 1; end
  
  
  # Rückgabe: self   
  def strip; self; end
  
  
  # Rückgabe: self  
  def dup; self; end      
  
  
  # see TestKyaniteTrueFalse#test_raumschiff_operator for tests  
  def <=>(other)
    return 1 if ! other
    return 0
  end  
  
  
  # Rückgabe: false    
  def blank?; false; end
  
  
end # class 




# [ | *Kyanite* | Object | Array | Set | Enumerable | Hash | ]    | Kyanite | TrueClass | *FalseClass* | NilClass | Div | 
#
# ---
#
# == *False*
#
class FalseClass
      
  # Rückgabe: 0
  def to_i; 0; end
  
  # Rückgabe: self  
  def strip; self; end  
  
  # Rückgabe: self  
  def dup; self; end    
  
  # see TestKyaniteTrueFalse#test_raumschiff_operator for tests
  def <=>(other)
    return -1 if other
    return 0
  end    
 
  
  # umdefiniert!
  #
  # TestKyaniteObject#test_blank  
  def blank?; self; end
  

  
end 





	
	
	
	
	
	
	
