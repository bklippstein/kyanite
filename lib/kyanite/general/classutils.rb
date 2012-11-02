# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


# @!group Class Utils

require 'facets/class/descendants'          # Methode descendants 
# require 'facets/kernel/singleton_class'     # Easy access to an object‘s "special" class, otherwise known as it‘s eigen or meta class.

# =================================================================================================================
#
# @!macro class_utils
#
# === Added from  {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-class-Class Facets Class}:  
# [+descendants(generations=-1))+] List all descedents of this class.
#
class Class
  
  # Comparison operator (alphabetical)
  # @return [Integer] 1, 0, -1
  def <=>(other) 
      ( ( self.to_s ) <=> ( other.to_s ) )
  end   
  
  
  # Fuzzy comparison of two classes (useful for tests)
  # @return [Boolean] 
  def =~(other)
    return true   if self == other
    return true   if self.descendants.include?(other)
    return true   if other.descendants.include?(self)
    return false
  end  

  # (see String#to_class)
  def to_class 
    self
  end     

  
  # (see String#to_classname)
  def to_classname
    self.to_s.demodulize.underscore
  end         
  
end # class




 


class String



  # Converts to a class name , the reverse of {String#to_class to_class}.
  #
  # classes {Class}, {Symbol}, {String}. The class name will contain only lowercase letters.
  #   'MyModul::MyClass'  =>  'my_class'
  #
  # Tests and examples {TestKyaniteClassutils here}.
  # @return [String]
  #
  def to_classname
      self.demodulize.underscore
  end
  
  
  # Converts to a class, the reverse of {String#to_classname to_classname}
  #
  # Defined for classes {Class}, {Symbol}, {String}. Accepts both CamelCase and down_case.
  #
  # Tests and examples {TestKyaniteClassutils here}.
  # @return [Class]
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
  # @return [String]  
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
  # @return [String]  
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
  # @return [String]  
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
  # @return [Class]  
  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{self.inspect} is not a valid constant name!"
    end

    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
end # String







# =================================================================================================================
#
# @!macro class_utils  
#
class Symbol

  # (see String#to_classname)
  def to_classname 
      self.to_s.to_classname
  end

  # (see String#to_class)
  def to_class 
      self.to_s.to_class
  end   

end # Symbol 





  # =================================================================================================================
  # @!macro class_utils
  #
  class NilClass

    # @return [String] empty String 
    def to_classname;             '';                   end  

    # @!group return nil   
    
    def camelize;                 nil;                  end 
    def constantize;              nil;                  end 
    def demodulize;               nil;                  end 
    def to_class;                 nil;                  end  
    def underscore;               nil;                  end 

  end












  
  