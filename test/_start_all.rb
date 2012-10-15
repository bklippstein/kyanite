# ruby encoding: utf-8
#!/usr/bin/env ruby
# 
#	Führt alle Tests aus
#

  if $0 == __FILE__ 
    require File.join(File.dirname(__FILE__), '..', 'smart_load_path.rb' )
    smart_load_path   
  end

  require 'transparent_nil'     
  
	# Test-Verzeichnis der Applikation
	test_verzeichnis = File.expand_path(File.dirname(__FILE__) )    
    
	Dir["#{test_verzeichnis}/test_*.rb"].sort.each { |t| require t }
	Dir["#{test_verzeichnis}/array/test_*.rb"].sort.each { |t| require t }
	Dir["#{test_verzeichnis}/enumerable/test_*.rb"].sort.each { |t| require t }
	Dir["#{test_verzeichnis}/general/test_*.rb"].sort.each { |t| require t }
	Dir["#{test_verzeichnis}/numeric/test_*.rb"].sort.each { |t| require t }
	Dir["#{test_verzeichnis}/string/test_*.rb"].sort.each { |t| require t }

  