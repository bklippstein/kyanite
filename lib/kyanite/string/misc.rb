# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end




# @!macro string
class String


  # @!group Miscellaneous


  # Counts the number of words.
  # @return [Integer] number of words
  def count_words
    n = 0
    scan(/\b\S+\b/) { n += 1}
    n
  end  
   
   
  # String substitution like +gsub+, but replaces multible patterns in one turn. Example:
  #  "between".mgsub([[/ee/, 'II'], [/e/, 'E']])      
  #  => "bEtwIIn"  
  # Tests {TestKyaniteStringMisc here}.
  # @return [String]
  def mgsub(search_and_replace_pairs)
    patterns = search_and_replace_pairs.collect { |search, replace| search }
    gsub(Regexp.union(*patterns)) do |match|
      search_and_replace_pairs.detect{ |search, replace| search =~ match}[1]
    end	
  end     
  

end


if defined? TransparentNil
  class NilClass

    # @return 0
    def count_words;                   0;          end  
    
    def mgsub(*a);                     nil;        end    
    
  end
end



# -----------------------------------------------------------------------------------------
#  ausprobieren
#
if $0 == __FILE__ then

  puts "between".mgsub([[/ee/, 'II'], [/e/, 'E']])  
  puts "between".mgsub([])  

end # if