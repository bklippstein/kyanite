# ruby encoding: utf-8
# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | Object | String | Symbol | *Numeric* |
# [ ] | *Numeric* | Integer | Float |  
#
# ---
#
# == *General* *Numeric* 
#
#
class Numeric

  # Zahlen sind schon numerisch:
  # Rückgabe self        
  def split_numeric 
      self 
  end    


  # Zahlen sind nicht empty:
  # Rückgabe false       
  def empty? 
      false 
  end  
  
  
  # siehe Array#shift_complement:
  # Rückgabe nil 
  def shift_complement 
    nil
  end    
  
  
  # Wandelt 0 in nil um
  def to_nil(*args)
    return nil  if self == 0
    self
  end
  
  
  # nil-sicheres subtrahieren 
  def substract(other)
    return nil if other.nil?
    self - other
  end
  
  
    
end # class


class NilClass
  def substract(other); nil; end
end