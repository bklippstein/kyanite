# ruby encoding: utf-8

# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | *Object* | String | Symbol | Numeric | Class | 
# [ ] | Object | KKernel | CallerUtils | *Undoable* | Class |
#
# ---
#
#
# == *Undo* 
#
#
module Undoable

  @@undoable_history = Hash.new

  # Speichert ein Objekt.
  # Verwendet standardmäßig Object#dup. Für komplexere Objekte muss allerdings Object#deep_copy genutzt werden.
  #
  def save(method=:dup)
    return if self == @@undoable_history[self.object_id] # nichts zu tun
    @@undoable_history[self.object_id] = self.send(method)
  end

  
  # Rückgriff auf den gespeicherten Zustand eines Objektes.
  # Der gespeicherte Zustand verbleibt im Speicher.
  # 
  def load_and_keep
    @@undoable_history[self.object_id]
  end
  
  
  # Rückgriff auf den gespeicherten Zustand eines Objektes.
  # Der gespeicherte Zustand wird verworfen. 
  #   
  def load_and_delete
    @@undoable_history.delete(self.object_id)
  end  
  
  
  # Verwirft alle gepeicherten Objektzustände.
  #
  def self.clear
    @@undoable_history.clear
  end


end