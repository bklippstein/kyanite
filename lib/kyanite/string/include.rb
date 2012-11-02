# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

class String

  # @!group Miscellaneous
    
  # @private
  alias :old_include? :include?
  
  # Now also accepts an Array as input parameter. 
  # The array elements are ORed, i.e. +include?+ is true if +old_include?+ is true for at least one element of the array. 
  # All strings include +''+, +[]+ or +nil+. 
  # +Nil+ does not include anything: +nil.include?  => false+
  #
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