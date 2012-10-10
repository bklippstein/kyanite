# ruby encoding: utf-8
require 'facets/timer'
require 'rbconfig'

unless defined? WINDOWS  
  WINDOWS = /djgpp|(cyg|ms|bcc)win|mingw/ =~ RUBY_PLATFORM ? RUBY_PLATFORM : false       
end

unless defined? RUBYDIR
  RUBYDIR = RbConfig::CONFIG['prefix']
  # puts "rubydir=" + RUBYDIR
end




# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | *Object* | String | Symbol | Numeric |  
# [ ] | Object | *KKernel* | CallerUtils | Undoable | Class | 
#
# ---
#
#
# == *General* *Tools*
#
#
module KKernel 

  # Wiederholt einen Block so lange, bis die Zeit abgelaufen ist.
  # Liefert die Anzahl der Durchläufe, die in dieser Zeit möglich waren.
  # Alle Exceptions werden abgefangen (=> fehlerhafte Blöcke scheinen schneller zu laufen)
  def repeat_n_seconds( n=1, &block )
    timer = Timer.new(n) 
    begin
      timer.start
        count = 0
        until false
          count += 1
          yield block
        end
      timer.stop
    rescue TimeoutError 
      return count      
    rescue 
      return count  
    rescue 
      return count             
    end # begin 
  end # def
  
  
  
  
  # Stellt für den nachfolgenden Block die Ruby-Warnungen ab.
  # Nützlich, um z.B. Konstanten zu überschreiben.
  # Quelle: Rails http://api.rubyonrails.org/classes/Kernel.html#M001639
  def silence_warnings
       old_verbose, $VERBOSE = $VERBOSE, nil
       yield
    ensure
       $VERBOSE = old_verbose
  end    
  
  
  # Vereinfacht die require-Statements in den Tests bei der Entwicklung von Libraries.  
  # Beim lokalen Aufruf eines einzelnen Tests wird die lokale Version der Library verwendet, nicht die installierte gem.
  # Verwendung:
  #   if $0 == __FILE__ 
  #     require 'kyanite/smart_load_path'
  #     smart_load_path   
  #   end
  #   require 'mygemproject'  
  #
  def smart_load_path(__file__ = nil)
    __file__ = caller[0] unless __file__
    dir_caller =File.dirname(__file__)
    
    #puts "smart_load_path " + dir_caller    
    
    patharray = dir_caller.split('/')
    patharray = dir_caller.split("\\")       if patharray.size == 1  
    # libpath = File.join(patharray)   
    patharray.size.times do |i|
      break   if File.directory?( File.join(patharray, 'lib') ) 
      patharray << '..'
    end
    newpath = File.join(patharray,'lib')  
    if $:.include?(newpath)
      return false
    else
      $:.unshift(newpath)  
      return true
    end
    
  end  #def  
  
  
end # module

class Object
  include KKernel
end


# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

# pp RUBYDIR

smart_load_path(__FILE__)
$LOAD_PATH.each do |path|
puts path
end

end










