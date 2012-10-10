# ruby encoding: utf-8

require 'rubygems'
require 'hoe'
require 'rake'
require File.dirname(__FILE__) + '/lib/kyanite'
require 'kyanite/rake'



#  ----------------------------------------------------------------------------------------------
#  Deploy
#  
# http://nubyonrails.com/articles/tutorial-publishing-rubygems-with-hoe
#
$hoe = Hoe.spec 'kyanite' do 

  # self.rubyforge_name = 'yourgemx' # if different than 'yourgem'
   
  developer('Bjoern Klippstein', 'klippstein@klippstein.com')
  summary               = 'General toolbox like Facets or ActiveSupport.'  
  urls                  << ['http://kyanite.rubyforge.org']   
  remote_rdoc_dir       = ''      # Release to root only one project
  extra_deps            << ['activesupport',   '>= 3.2.8']
  extra_deps            << ['facets',          '>= 2.9.3']
  extra_deps            << ['rubytree',        '>= 0.8.3'] 

  
  
                              
                              
                              
end




#  ----------------------------------------------------------------------------------------------
#  Local Tasks
#  

remove_task 'ridocs'
remove_task 'rdoc' 
remove_task 'docs' 
remove_task 'audit' 
remove_task 'dcov' 
remove_task 'debug_email' 
remove_task 'debug_gem' 
remove_task 'deploy' 
remove_task 'deps:email' 
remove_task 'install_gem'
remove_task 'multi' 
remove_task 'newb' 
Dir['tasks/**/*.rake'].each { |t| load t }





# ---------------------------------------------------------
# git
#
    
  # git_status
  #
  desc 'git status'
  task :git_status do
    sh "#{'sudo ' unless Hoe::WINDOZE }git status"
  end        
    
  
  
  # git_add
  #
  desc 'git_add -A'
  task :git_add do
    sh "#{'sudo ' unless Hoe::WINDOZE }git add -A"
  end    
    
  
  
  # git_commit
  #
  desc 'git commit -m'
  task :git_commit do
    sh "#{'sudo ' unless Hoe::WINDOZE }git commit " + ' -m "rake commit"'
  end  


  # git push origin master
  #
  desc 'git_push'
  task :git_push do
    sh "#{'sudo ' unless Hoe::WINDOZE }git push origin master"
  end  


  
  # git_publish
  #
  desc ':git_add, :git_commit, :git_push'
  task :git_publish => [ :git_add, :git_commit, :git_push ] do
    puts
    puts 'done. Visit https://github.com/bklippstein/kyanite'
  end  






