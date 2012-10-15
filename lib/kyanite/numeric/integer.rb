# ruby encoding: utf-8
# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | Object | String | Symbol | *Numeric* | 
# [ ] | Numeric | *Integer* | Float |  
#
# ---
#
# == *Trivial* *Integer* *Methods* 
#
#
class Integer

  # Wandelt eine Sekundenzahl-seit-1970 in ein Time-Objekt
  def to_time
    return nil if self > 2099999999     # geht leider nur bis ins Jahr 2036 
    ::Time.at(self)                     # ohne die Doppelpunkte sucht Ruby die Methode at in ::Time und wirft einen Error
  end     
  
  # Rückgabe: self    
  # Test: TestKyaniteNumeric#test_integer_triviales
  def to_integer;                     self;            end     
  
  
  # Rückgabe: self    
  # Test: TestKyaniteNumeric#test_integer_triviales
  def to_integer_optional;            self;            end  
  
  
  # Rückgabe: self    
  # Test: TestKyaniteNumeric#test_integer_triviales
  def dup;                            self;            end        
  
end # class


if defined? TransparentNil
  class NilClass
    def to_time;                        nil;            end   
  end
end


