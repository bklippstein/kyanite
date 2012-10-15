# ruby encoding: utf-8


# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | *Object* | String | Symbol | Numeric |
# [ ] | *Object* | KKernel | CallerUtils | Undoable | Class | 
#
# ---
#
#
# == *For* *All* *Objects*
# Tests and examples see TestKyaniteObject
#
#
class Object
 
    # <tt> false </tt>    
    #
    # Tests and examples see TestKyaniteObject    
    #
    def blank? 
        false
    end     

    
    # Quelle: Facets http://facets.rubyforge.org/quick/rdoc/core/classes/Kernel.html#M000379
    #
    def respond(sym, *args)
      return nil if not respond_to?(sym)
      send(sym, *args)
    end    
    
    
    # Alternative zu Object#dup. Dupliziert auch Unterobjekte. Langsam.
    # Wird z.B. für Undo-Operationen verwendet, siehe Modul Undoable.
    # 
    def deep_copy
      Marshal.load( Marshal.dump( self ) )
    end

    
    # Ist ein Objekt numerisch?
    #
    # Tests and examples see TestKyaniteObject    
    #
    def is_numeric?
      Float self 
    rescue #Exception => e
      false 
    end        
    
    
    # <tt> false </tt>    
    def empty? 
        false
    end  

    

    
    
    # Liefert nil, wenn die Condition erfüllt ist. Sonst self.
    #
    def to_nil(condition = :empty) 
        return nil         if self.respond(condition.to_s + '?')
        return self
    end    
    
    
    # Liefert nil, wenn die Condition nicht erfüllt ist. Sonst self.
    #
    def to_nil_unless(condition = :empty) 
        return nil         unless self.respond(condition.to_s + '?')
        return self
    end    


    # Findet den Namen einer Ruby-Konstanten anhand seines Wertes.
    # Funktioniert so nicht. Seltsamersweise funktioniert es aber, wenn man den Quelltext dieser Methode direkt ausführt.
    # Verwendet in der Info-Ansicht des Scaffoldings.
    #
    def name_of_constant(wert_der_konstanten)
      Object.constants.find { |c| Object.const_get(c) == wert_der_konstanten}
    end    
end



if defined? TransparentNil
  class NilClass
   
    # Rückgabe: false
    def blank?;                         false;          end    

    # Rückgabe: false
    def is_numeric?;                    false;          end
    
    def to_nil;                         nil;            end   
    def to_nil_unless(*a);              nil;            end   
    def name_of_constant(*a);           nil;            end   
  end
end




