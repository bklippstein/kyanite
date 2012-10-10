# ruby encoding: utf-8
# Required eine Auswahl wichtiger Kyanite-Libs


# ----------------------------------------------------------------
# innerhalb von Verzeichnissen
#

# require 'kyanite/array'   
  require 'kyanite/array/array'           # aber nicht array2 und matrix2 
  
# require 'kyanite/general'    
# require 'kyanite/general/callerutils'
  require 'kyanite/general/classutils'  
  require 'kyanite/general/kernel'     
  require 'kyanite/general/nil'     
  require 'kyanite/general/object'    
# require 'kyanite/general/optimizer'    
  require 'kyanite/general/true_false'       
# require 'kyanite/general/undoable'       
   
  require 'kyanite/numeric'    
# require 'kyanite/operation'              # nur manuell
  
# require 'kyanite/string'     
# require 'kyanite/string/cast'
# require 'kyanite/string/chars'
# require 'kyanite/string/diff'
# require 'kyanite/string/div'
  require 'kyanite/string/include'
# require 'kyanite/string/list'
  require 'kyanite/string/mgsub'
# require 'kyanite/string/nested'
# require 'kyanite/string/random'
# require 'kyanite/string/split'

  
  
  
# ----------------------------------------------------------------
# Einzeldateien
#  
  
# require 'kyanite/basics'            # diese Datei  
# require 'kyanite/dictionary'   
  require 'kyanite/hash'   
# require 'kyanite/matrix2'   
# require 'kyanite/nil'               # ist schon in general
  require 'kyanite/range'  
# require 'kyanite/set'  
  require 'kyanite/symbol'  
# require 'kyanite/tree'  
# require 'kyanite/unit_test'         # nur für Tests
         
# ----------------------------------------------------------------
# Außerhalb
#  

require 'pp'