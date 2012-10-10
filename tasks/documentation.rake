# ruby encoding: utf-8
 
#  ----------------------------------------------------------------------------------------------
#  Documentation
#  
# http://rubeh.tumblr.com/post/27622544/rake-rdoctask-with-all-of-the-options-stubbed-out
# http://www.java2s.com/Code/Ruby/Language-Basics/RDocoptionsareusedlikethisrdocoptionsnames.htm

require 'rdoc/task'


desc "Generate RDoc documentation for Kyanite"
Rake::RDocTask.new(:docs) do |rd|
    rd.title    = "Kyanite"

    rd.rdoc_dir = 'doc'   
    rd.rdoc_files.include('lib/**/*.rb')
    rd.rdoc_files.include('test/**/test_*.rb')
    rd.rdoc_files.include('README.txt', 'License.txt', 'Div')
    
    rd.rdoc_files.exclude('lib/kyanite/array/array2')
    rd.rdoc_files.exclude('lib/kyanite/array/matrix2')
    rd.rdoc_files.exclude('lib/kyanite/operation/call_tracker')
    #rd.rdoc_files.exclude('lib/kyanite.rb')
    
    #rd.main = 'README.txt'

      
    rd.options += [
        '--tab-width', '4',
        '--main', 'README.txt',
        '--show-hash',        # A name of the form #name in a comment is a possible hyperlink to an instance method name. When displayed, the # is removed unless this option is specified.
        '--line-numbers',
        '--all',
        '--charset=utf8'      
      ]      
      
end

