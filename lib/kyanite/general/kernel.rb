# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'facets/timer'



# @!macro object
module KKernel 

  # @!macro [new] seconds
  #  Repeats a block until the time is up. 
  #  Returns the number of passes. All Exceptions are caught (=> bad blocks seem to run faster).
  #  Example (using {Numeric}):
  #   3.seconds do
  #    puts Time.now.inspect
  #   end  
  #  Example (using {KKernel}):
  #   repeat_n_seconds 3 do
  #    puts Time.now.inspect
  #   end
  #
  def repeat_n_seconds( n=1, &block )
    timer = Timer.new(n) 
    begin
      timer.start
        count = 0
        until false
          count += 1
          yield block if block
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
  
  
  
  

  
  # Silence all Ruby warnings for the following block. Useful to override constants.
  # Example:
  #  TEST = 1
  #  silence_warnings do
  #   TEST = 2
  #  end  
  #
  def silence_warnings
       old_verbose, $VERBOSE = $VERBOSE, nil
       yield
    ensure
       $VERBOSE = old_verbose
  end    
  
  

  
  
end 

class Object
  include KKernel
end

class Numeric

  # @!macro seconds
  def seconds( &block )
    repeat_n_seconds( self ) do 
          yield block if block    
    end
  end
  
end


# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

TEST = 1
silence_warnings do
TEST = 2
end
puts TEST
end










