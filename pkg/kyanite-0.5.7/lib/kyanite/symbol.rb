# ruby encoding: utf-8

# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | Object | String | *Symbol* | Numeric | 
#
# ---
#
# == *Symbol*
#
#
class Symbol
  
    # Rückgabe: false
    def empty?;                         false;           end  
    
    # Rückgabe: self    
    def dup;                            self;            end  
    
    # wie gleichlautende String-Funktion   
    def +(other)
      (self.to_s + other.to_s).to_sym
    end
    
    # wie gleichlautende String-Funktion       
    def <=>(other)
      self.to_s <=> other.to_s
    end
    
    # wie gleichlautende String-Funktion       
    def size
      self.to_s.size
    end
    
end 