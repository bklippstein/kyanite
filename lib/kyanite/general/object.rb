# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end



# @!macro object
class Object
 
    # Returns +false+
    # @return [false]
    def blank? 
        false
    end     

    

    # Like +respond_to?+ but returns the result of the call if it does indeed respond.
    # See {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-module-Kernel/api-method-Kernel-h-respond Facets +Kernel#respond+}.
    def respond(sym, *args)
      return nil if not respond_to?(sym)
      send(sym, *args)
    end    
    
    
    # Slow but in-depth alternative to +dup+. Also duplicates sub-objects. Is e.g. for undo operations used, see module {Undoable}.
    def deep_copy
      Marshal.load( Marshal.dump( self ) )
    end

    
    # Is the object numeric?
    # Tests see {TestKyaniteObject here}.   
    #
    def is_numeric?
      Float self 
    rescue #Exception => e
      false 
    end        
    
    # Returns +false+    
    # @return [false]  
    def empty? 
        false
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
   
    # +false+
    # @return [false]
    def blank?;                         false;          end    

    # +false+    
    # @return [false]
    def is_numeric?;                    false;          end
    
    def name_of_constant(*a);           nil;            end   
  end
end




