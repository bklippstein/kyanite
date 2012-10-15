# ruby encoding: utf-8
require 'transparent_nil'
require 'kyanite/symbol'

class String

# ---------------------------------------------------------------------------------------------------------------------------------
# :section: List / Database
# See TestKyaniteStringList for tests and examples.     
  
  
  # Listet Text auf. Beispiele siehe TestKyaniteStringList
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


  
  # Gibt eine SQL-RegExp zurück, mit der man in Postgres kommaseparierte Listen duchsuchen kann.  
  # Anwendung: Model Merkmal, has_many :dienste_req
  # 
  def sql_regexp_for_kommaliste
     '[, ]'  + self  + '[, ]'          + '|' +       # match mittendrin
     '^'     + self  + '[, ]'          + '|' +       # match am Anfang
     '[, ]'  + self  + '$'             + '|' +       # match am Ende
     '^'     + self  + '$'                           # match von Anfang bis Ende
  end 
  
  
  # macht aus einer MySQL-Enum-Angabe ein Array
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

