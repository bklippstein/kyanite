# ruby encoding: utf-8

# Required alle Kyanite-Libs
# -- eine Auswahl der wichtigsten Kyanite-Libs required man mit 
# require 'kyanite/basics'


if $:.include?(File.dirname(__FILE__))  ||  $:.include?(File.expand_path(File.dirname(__FILE__)))
  #puts 'Path schon aktuell'
else
  $:.unshift(File.dirname(__FILE__)) 
end




module Kyanite #:nodoc
  VERSION  = '0.5.11'
end
    

  require 'kyanite/array'
# require 'kyanite/basics'            # Auswahl
  require 'kyanite/dictionary'
  require 'kyanite/enumerable'       
  require 'kyanite/general'
  require 'kyanite/hash'
# require 'kyanite/matrix2'           # ist schon in array
# require 'kyanite/nil'               # ist schon in general
  require 'kyanite/numeric'
# require 'kyanite/operation'         # nur manuell   
  require 'kyanite/optimizer'
  require 'kyanite/range'
  require 'kyanite/set'
  require 'kyanite/string'
  require 'kyanite/symbol'
  require 'kyanite/tree'
# require 'kyanite/unit_test'         # nur für Tests
