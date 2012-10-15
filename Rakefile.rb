# ruby encoding: utf-8

projectname = File.dirname(__FILE__).split("/")[-1].strip   # Name des Projekt-Stammverzeichnisses
require File.dirname(__FILE__) + "/lib/#{projectname}"      # Hauptdatei der Library

require 'kyanite/hoe'
Kyanite.projectname = projectname
Kyanite.github_username = 'bklippstein'

require 'rdoc/task'
require 'kyanite/rake'




#  ----------------------------------------------------------------------------------------------
#  Hoe
#  
# http://nubyonrails.com/articles/tutorial-publishing-rubygems-with-hoe
#
$hoe = Hoe.spec Kyanite.projectname do 

  # self.rubyforge_name = 'yourgemx' # if different than 'yourgem'
   
  developer('Bjoern Klippstein', 'klippstein@klippstein.com')
  summary               = 'General toolbox like Facets or ActiveSupport.'  
  extra_deps            << ['transparent_nil', '>= 0.1.3']
  extra_deps            << ['activesupport',   '>= 3.2.8']
  extra_deps            << ['facets',          '>= 2.9.3']
  extra_deps            << ['rubytree',        '>= 0.8.3'] 
  remote_rdoc_dir = '' # Release to root only one project  
  urls                  = [["http://#{Kyanite.github_username}.github.com/#{Kyanite.projectname}/"]]

                    
end

# require 'pp'
# pp $hoe


  
  
  
#  ----------------------------------------------------------------------------------------------
#  Documentation
#  
# http://rubeh.tumblr.com/post/27622544/rake-rdoctask-with-all-of-the-options-stubbed-out
# http://www.java2s.com/Code/Ruby/Language-Basics/RDocoptionsareusedlikethisrdocoptionsnames.htm
#   

remove_task 'docs' 

desc "generate RDoc documentation"
Rake::RDocTask.new(:docs) do |rd| 

    rd.title    = "#{Kyanite.projectname.capitalize} #{Kyanite.projectname.to_class.const_get('VERSION')}"

    rd.rdoc_dir = 'doc'   
    rd.rdoc_files.include('lib/**/*.rb')
    rd.rdoc_files.include('test/**/test_*.rb')
    rd.rdoc_files.include('README.txt', 'License.txt', 'History.txt', 'Div')
    
    rd.rdoc_files.exclude('lib/kyanite/array/array2')
    rd.rdoc_files.exclude('lib/kyanite/array/matrix2')
    rd.rdoc_files.exclude('lib/kyanite/operation/call_tracker')

    rd.options += [
        '--tab-width', '4',
        '--main', 'README.txt',
        '--show-hash',        # A name of the form #name in a comment is a possible hyperlink to an instance method name. When displayed, the # is removed unless this option is specified.
        '--line-numbers',
        '--all',
        '--charset=utf8'      
      ]      
      
end

  
#  ----------------------------------------------------------------------------------------------
#  Local Tasks
#  

remove_task 'ridocs'
remove_task 'rdoc' 
remove_task 'audit' 
remove_task 'dcov' 
remove_task 'debug_email' 
remove_task 'debug_gem' 
remove_task 'deploy' 
remove_task 'deps:email' 
remove_task 'install_gem'
remove_task 'multi' 
remove_task 'newb' 
#Dir['tasks/**/*.rake'].each { |t| load t }  
  
  
  




