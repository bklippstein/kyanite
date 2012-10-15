# ruby encoding: utf-8

require 'facets/kernel/singleton_class'     # Easy access to an object‘s "special" class, otherwise known as it‘s eigen or meta class.
require 'facets/class/descendants'          # Methode   descendants 


# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | *Object* | String | Symbol | Numeric | 
# [ ] | Object | KKernel | CallerUtils | Undoable | *Class* | 
#
# ---
#
# == *Class* *Utils*  
# See TestKyaniteClassutils for tests and examples.
#
class Class
  
  # Vergleichsoperator: Alphabetisch. 
  def <=>(other) 
      ( ( self.to_s ) <=> ( other.to_s ) )
  end   
  
  
  # Unscharfer Vergleich zweier Klassen, z.B. für Tests
  def =~(other)
    return true   if self == other
    return true   if self.descendants.include?(other)
    return true   if other.descendants.include?(self)
    return false
  end  

  # Die Methode to_class wandelt einen Klassennamen in eine Klasse.
  # Die Methode gibt es insbesondere für String und Symbol, siehe String#to_class, Symbol#to_class  
  # Für Class ist sie einfach transparent, d.h. sie liefert self.   
  # Tests and examples see TestKyaniteClassutils
  # 
  def to_class 
    self
  end     

  
  # Gegenstück zu to_class: 
  # Wandelt eine Klasse in einen Klassennamen um, der nur Kleinbuchstaben enthält.
  # Siehe String#to_classname, Symbol#to_classname
  # Tests and examples see TestKyaniteClassutils
  #
  def to_classname
    self.to_s.demodulize.underscore
  end         
  
end # class





  
class Symbol

  # Wandelt ein Symbol in einen Klassennamen, der nur Kleinbuchstaben enthält. 
  # Siehe String#to_classname     
  # Tests and examples see TestKyaniteClassutils
  #
  def to_classname 
      self.to_s.to_classname
  end

  # Wandelt einen Klassennamen in eine Klasse.
  # Akzeptiert sowohl CamelCase als auch down_case.
  # Die Methode gibt es auch für String und Class.
  # Tests and examples see TestKyaniteClassutils
  #
  def to_class 
      self.to_s.to_class
  end   

end # class 




  
 
  
class String  

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Class Utils
  # See TestKyaniteClassutils for tests and examples.
  #  


  # Wandelt einen String in einen Klassennamen, der nur Kleinbuchstaben enthält. 
  #   'MeinModul::EineKlasse'  =>  'eine_klasse'
  #
  # Tests and examples see TestKyaniteClassutils
  #
  def to_classname
      self.demodulize.underscore
  end
  
  

  # Wandelt einen Klassennamen in eine Klasse.
  # Akzeptiert sowohl CamelCase als auch down_case.
  # Die Methode gibt es auch für Symbol und Class.
  # Tests and examples see TestKyaniteClassutils
  #
  def to_class
      self.camelize.constantize
  rescue
      return nil
  end
  



  # The reverse of +camelize+. Makes an underscored, lowercase form from the expression in the string.
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # Examples:
  #   "ActiveRecord".underscore         # => "active_record"
  #   "ActiveRecord::Errors".underscore # => active_record/errors
  # From ActiveSupport, Copyright (c) 2005 David Heinemeier Hansson. See License.txt.  
  #  
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
  
  
  
  # By default, +camelize+ converts strings to UpperCamelCase. If the argument to +camelize+
  # is set to <tt>:lower</tt> then +camelize+ produces lowerCamelCase.
  #
  # +camelize+ will also convert '/' to '::' which is useful for converting paths to namespaces.
  #
  # Examples:
  #   "active_record".camelize                # => "ActiveRecord"
  #   "active_record".camelize(:lower)        # => "activeRecord"
  #   "active_record/errors".camelize         # => "ActiveRecord::Errors"
  #   "active_record/errors".camelize(:lower) # => "activeRecord::Errors"
  # From ActiveSupport, Copyright (c) 2005 David Heinemeier Hansson. See License.txt.   
  #  
  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      self.first + camelize(self)[1..-1]
    end
  end  
  
  
  # Removes the module part from the expression in the string.
  #
  # Examples:
  #   "ActiveRecord::CoreExtensions::String::Inflections".demodulize # => "Inflections"
  #   "Inflections".demodulize                                       # => "Inflections"
  # From ActiveSupport, Copyright (c) 2005 David Heinemeier Hansson. See License.txt.   
  #  
  def demodulize
    self.gsub(/^.*::/, '')
  end  
  
  

  # Tries to find a constant with the name specified in the argument string:
  #
  #   "Module".constantize     # => Module
  #   "Test::Unit".constantize # => Test::Unit
  #
  # The name is assumed to be the one of a top-level constant, no matter whether
  # it starts with "::" or not. No lexical context is taken into account:
  #
  #   C = 'outside'
  #   module M
  #     C = 'inside'
  #     C               # => 'inside'
  #     "C".constantize # => 'outside', same as ::C
  #   end
  #
  # NameError is raised when the name is not in CamelCase or the constant is
  # unknown.
  # From ActiveSupport, Copyright (c) 2005 David Heinemeier Hansson. See License.txt.   
  #
  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{self.inspect} is not a valid constant name!"
    end

    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
end # class  

if defined? TransparentNil
  class NilClass

    # Rückgabe: Leerer String  
    def to_classname;             '';                   end  

    def camelize;                 nil;                  end 
    def constantize;              nil;                  end 
    def demodulize;               nil;                  end 
    def to_class;                 nil;                  end  
    def underscore;               nil;                  end 

  end
end











  
  