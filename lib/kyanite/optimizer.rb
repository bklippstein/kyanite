# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

 



# @!macro optimizer
# ==== Example
#   require 'kyanite/optimizer' 
#   test = Optimizer.new
#   test.push  1,  'hello'
#   test.push  5,  'item'
#   test.push  6,  'maximum23'
#   test.push -1,  'minimum'
#   test.push -1,  'another minimum'  
#   test.content_max
#   >= "maximum23"
#   test.content_min
#   >= "minimum"
# More tests and examples {TestKyaniteOptimizer here}. 
#
class Optimizer < Hash

# Drei Stufen für Marshall sind denkbar:
# * kein Marshal
# * Marshal.load(Marshal.dump) beim Schreiben. Dadurch sind Schreibzugriffe teuer, Lesezugriffe aber billig
# * Marshal.dump beim Schreiben, Marshal.load beim Lesen. Dadurch sind Lese- und Schreibzugriffe teuer, 
#   die im Optimizer gespeicherten Objekte sind aber abgeschottet und geschützt.

#@@marshal = true

  # def initialize( options={} )
    # @@marshal = options[:marshal]  || true
  # end
  
  

  # @return [Numeric] Value of maximum score
  def score_max
    return nil  if size == 0  
    keys.max
  end
  
  
  # @return [Numeric] Value of minimum score
  def score_min
    return nil  if size == 0  
    keys.min
  end  
  
  
  # Returns the content with maximum score. 
  #  content_max(0)      # returns the first content with maximum score
  #  content_max(-1)     # returns the last content with maximum score  
  #  content_max(0..-1)  # returns all contents with maximum score (as Array)
  #
  def content_max(range=0..0)
    return nil  if size == 0
    range = (range..range) if range.kind_of?(Fixnum)    
    if (range.end - range.begin) == 0
      return Marshal.load(self[keys.max][range.begin])
    else
      result = []
      self[keys.max][range].each do | m |
        result << Marshal.load(m)
      end
      return result
    end
  end
  
  
  # Returns the content with minimum score. 
  #  content_min(0)      # returns the first content with minimum score
  #  content_min(-1)     # returns the last content with minimum score  
  #  content_min(0..-1)  # returns all contents with minimum score (as Array)
  #
  def content_min(range=0..0)
    return nil  if size == 0
    range = (range..range) if range.kind_of?(Fixnum)    
    if (range.end - range.begin) == 0
      return Marshal.load(self[keys.min][range.begin])
    else
      result = []
      self[keys.min][range].each do | m |
        result << Marshal.load(m)
      end
      return result
    end
  end 
  
  
  # Load the optimizer with objects.
  def push( score, content, options={} )
    if self.has_key?(score) 
      self[score] << Marshal.dump(content) 
    else
      self[score] = [ Marshal.dump(content) ]
    end
  end
  
  
  # Deletes all objects in the middle.
  def cleanup
    return false if size <= 2
    keys.sort[1..-2].each do | key | 
      self.delete(key)
    end
    true
  end
  
  
  # Deletes the object with the lowest score. 
  def delete_min
    return false if size <= 1
    self.delete(keys.min)
    true
  end  
  
  # Deletes the object with the highest score.    
  def delete_max
    return false if size <= 1
    self.delete(keys.max)
    true
  end    



  


end #class














