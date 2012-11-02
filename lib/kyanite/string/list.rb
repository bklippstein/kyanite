# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'transparent_nil'
require 'kyanite/symbol'

class String


# @!group Database-Helper 
  
  
  # Generates WHERE clause from {Array}.
  #  
  # Example:
  #  array = ['Anna','Birte','Charlie']
  #  "kisses_from = ".list_with(array)
  #  => "kisses_from = 'Anna' OR kisses_from = 'Birte' OR kisses_from = 'Charlie'"
  #
  # See tests and more examples {TestKyaniteStringList here}.
  # @return [String]
  def list_with(  elemente, options = {}, &block )
  
    options = { :pre    => %q{'},
                :post   => %q{'},
                :sep    => ' OR ',
                :empty => 'FALSE'}.merge(options)

    
    # keine Liste angegeben
    return options[:empty]     if elemente.empty? 
    
    
    # einzelnen String oder einzelnes Symbol angegeben -> ohne Separator ausgeben
    if elemente.kind_of?(String)  ||  !elemente.respond_to?(:each_index) 
      e = elemente.dup          
      e = yield e               if block_given?    
      return "#{self}#{options[:pre]}#{e}#{options[:post]}"     
    end
    
    
    # Liste hat nur ein Element -> ohne Separator ausgeben
    if elemente.size <= 1  
      e = elemente[0].dup
      e = yield e               if block_given?    
      return "#{self}#{options[:pre]}#{e}#{options[:post]}"     
    end      
    
    
    # Liste hat mehrere Elemente
    result = ''
    elemente[0..-2].each do |e|
      # Die vorderen Elemente mit Separator
      e = yield e               if block_given?
      result += "#{self}#{options[:pre]}#{e}#{options[:post]}#{options[:sep]}"  
    end
      # Letztes Element ohne Separator 
      e = elemente[-1].dup
      e = yield elemente[-1]    if block_given?
      result += "#{self}#{options[:pre]}#{e}#{options[:post]}" 
    result
  end


  
  # Returns SQL-RegExp for searching in Postgres comma-separated list.
  # @return [String]
  #
  def sql_regexp_for_kommaliste
     '[, ]'  + self  + '[, ]'          + '|' +       # match mittendrin
     '^'     + self  + '[, ]'          + '|' +       # match am Anfang
     '[, ]'  + self  + '$'             + '|' +       # match am Ende
     '^'     + self  + '$'                           # match von Anfang bis Ende
  end 
  
  
  # Converts MySQL-Enum to {Array}.
  # @return [Array]
  #
  def enum_to_array
    self[5..-2].gsub("'",'').split(',').collect {|i| [i,i] }
  end    

  

end

if defined? TransparentNil
  class NilClass
    def list_with(*a);                       nil;            end
    def sql_regexp_for_kommaliste;           nil;            end
    def enum_to_array;                       nil;            end
  end
end


# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

require 'kyanite/string/chars'
    array = ['Anna','Birte','Charlie']
    puts "kisses_from = ".list_with(array)  





end

