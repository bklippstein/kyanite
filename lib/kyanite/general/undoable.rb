# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


# @!macro undoable
module Undoable

  @@undoable_history = Hash.new

  # Saves an object. 
  # @param method [Symbol] method to use. Default is +:dup+. For more complex objects use {Object#deep_copy +:deep_copy+} instead.
  #
  def save(method=:dup)
    return if self == @@undoable_history[self.object_id] # nichts zu tun
    @@undoable_history[self.object_id] = self.send(method)
  end

  
  # Loads a saved state of an object, the saved state remains in memory.
  # 
  def load_and_keep
    @@undoable_history[self.object_id]
  end
  
  
  # Loads a saved state of an object, the saved state will be discarded.
  #   
  def load_and_delete
    @@undoable_history.delete(self.object_id)
  end  
  
  
  # Discards all saved states of all objects.
  #
  def self.clear
    @@undoable_history.clear
  end


end