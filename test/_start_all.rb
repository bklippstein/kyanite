# ruby encoding: utf-8
# 
#	Führt alle Tests aus
#

if $0 == __FILE__ 
  require 'drumherum'
  smart_init  
end

require 'transparent_nil'     
  
  
# Test-Verzeichnisse der Applikation
Dir["#{File.join(Drumherum::directory_main, 'test')}/test_*.rb"].sort.each { |t| require t }  

Dir["#{File.join(Drumherum::directory_main, 'test', 'array' )}/test_*.rb"].sort.each { |t| require t }  
Dir["#{File.join(Drumherum::directory_main, 'test', 'enumerable' )}/test_*.rb"].sort.each { |t| require t }  
Dir["#{File.join(Drumherum::directory_main, 'test', 'general' )}/test_*.rb"].sort.each { |t| require t }  
Dir["#{File.join(Drumherum::directory_main, 'test', 'numeric' )}/test_*.rb"].sort.each { |t| require t }  
Dir["#{File.join(Drumherum::directory_main, 'test', 'string' )}/test_*.rb"].sort.each { |t| require t }  


  


  