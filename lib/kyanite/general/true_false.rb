# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


# @!macro true_false
class TrueClass  
     
     
  # Returns +1+
  # @return [1]  
  def to_i; 1; end
  
  
  # Returns +self+
  # @return [self]   
  def strip; self; end
  
  
  # Returns +self+
  # @return [self]  
  def dup; self; end      
 
  
  # Defines true <=> true, true <=> false, false <=> true, false <=> false.
  # See Tests {TestKyaniteTrueFalse#test_raumschiff_operator here}.  
  def <=>(other)
    return 1 if ! other
    return 0
  end  
  
  
  # Returns +false+
  # @return [false]    
  def blank?; false; end
  
  
end # class 




# @!macro true_false
class FalseClass
      
  # Returns +0+
  # @return [0]  
  def to_i; 0; end
 
 
  # Returns +self+
  # @return [self]  
  def strip; self; end  

  
  # Returns +self+
  # @return [self]  
  def dup; self; end    

  
  # (see TrueClass#<=>)
  def <=>(other)
    return -1 if other
    return 0
  end    
 
  
  # Returns +false+
  # @return [self]  
  def blank?; self; end
  

  
end 





	
	
	
	
	
	
	
