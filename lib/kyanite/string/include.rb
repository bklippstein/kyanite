# ruby encoding: utf-8
class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: include
  #  
  
  alias :old_include? :include?
  
  # Nimmt jetzt auch ein Array an. 
  # Die Array-Elemente werden ODER-verknüpft, d.h. 
  # include? ist true, wenn für mindestens eines der Elemente include? true ist.
  # Alle Strings includen '', [] oder nil. 
  # Andersherum enthält nil niemals irgendwas (nil.include?  => false)
  def include?(input)
    return true if input.nil?
    return true if input.empty?
    if ( input.respond_to?(:each)  &&  !input.kind_of?(String) )
     input.each do |frag|
        return true if include?(frag)
     end
     false
    else
      old_include?(input)
    end
  end # def
end

if defined? TransparentNil
  class NilClass

      # Rückgabe: false
      # redundante Definition!        
      def include?(*a);                   false;          end  
  end
end

# -----------------------------------------------------------------------------------------
#  ausprobieren
#
if $0 == __FILE__ then

  # puts 'hallo'.include?('ll')
  # puts 'hallo'.include?('lh')
  #puts 'hallo'.include?(['gg'])
  #puts 'hallo'.include?(['lh','gg'])
  puts 'hallo'.include?('')
  puts 'hallo'.include?(nil)
  puts nil.include?(nil)

end # if