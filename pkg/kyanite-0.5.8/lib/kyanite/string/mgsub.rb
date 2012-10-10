# ruby encoding: utf-8
# ü



class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: mgsub
  #  
 
  # Mehrere Patterns mit einer RegExp replacen.
  # Ruby Cookbook Seite 32 
  #  "between".mgsub([[/ee/, 'AA'], [/e/, 'E']])      # Good code
  #  => "bEtwAAn"
  #  
  def mgsub(key_value_pairs=[].freeze)
    regexp_fragments = key_value_pairs.collect { |k,v| k }
    gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect{|k,v| k =~ match}[1]
    end	
  end   
  # http://oreilly.com/catalog/9780596523695/
  # Ruby Cookbook, by Lucas Carlson and Leonard Richardson
  # Copyright 2006 O'Reilly Media  
 
end # class 
 
 
class NilClass
  def mgsub(*a);                       nil;            end
end
 
 
 
# -----------------------------------------------------------------------------------------
#  ausprobieren
#
if $0 == __FILE__ then

  puts "between".mgsub([[/ee/, 'AA'], [/e/, 'E']])  

end # if