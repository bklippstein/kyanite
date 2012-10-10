#!/usr/bin/env ruby
# File: script/console
irb = RUBY_PLATFORM =~ /(:?mswin|mingw)/ ? 'irb.bat' : 'irb'

libs =  " -r irb/completion"
# Perhaps use a console_lib to store any extra methods I may want available in the cosole
# libs << " -r #{File.dirname(__FILE__) + '/../lib/console_lib/console_logger.rb'}"
libs <<  " -r #{File.dirname(__FILE__) + '/../lib/kyanite.rb'}"
puts "Welcome to Kyanite gem"
exec "#{irb} #{libs} --simple-prompt --noreadline"