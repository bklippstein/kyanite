# ruby encoding: utf-8

$github_username = 'bklippstein'
$projectname = File.dirname(__FILE__).split("/")[-1].strip  # Name des Projekt-Stammverzeichnisses


require 'rubygems'
require 'hoe'
require 'rake'
require File.dirname(__FILE__) + "/lib/#{$projectname}"     # Hauptdatei der Library
require 'kyanite/rake'
require 'rdoc/task'



#  ----------------------------------------------------------------------------------------------
#  Hoe
#  
# http://nubyonrails.com/articles/tutorial-publishing-rubygems-with-hoe
#
$hoe = Hoe.spec $projectname do 

  # self.rubyforge_name = 'yourgemx' # if different than 'yourgem'
   
  developer('Bjoern Klippstein', 'klippstein@klippstein.com')
  summary               = 'General toolbox like Facets or ActiveSupport.'  
  urls                  << ["http://#{$github_username}.github.com/#{$projectname}/"]   
  remote_rdoc_dir       = ''      # Release to root only one project
  extra_deps            << ['activesupport',   '>= 3.2.8']
  extra_deps            << ['facets',          '>= 2.9.3']
  extra_deps            << ['rubytree',        '>= 0.8.3'] 


                    
end

# require 'pp'
# pp $hoe


# -------------------------------------------------------------------------------------------------------
# publish
#

  # Task :publish
  #
  desc 'publish all on github and rubygems, reinstall gem'
  task :publish => [ :redocs, :rubygems_publish, :gem_uninstall, :git_publish, :git_publish_docs, :sleep_15, :gem_install] do
    puts 'done.'
  end  



# -------------------------------------------------------------------------------------------------------
# git
#


  # git_publish
  #
  desc ':git_add, :git_commit, :git_push'
  task :git_publish => [ :git_add, :git_commit, :git_push ] do
    puts
    puts '------------------------------------------------------------------------------------'
    puts ':git_publish          publish project to github '
    puts     
    if Hoe::WINDOZE
      sh "start https://github.com/#{$github_username}/#{$projectname} "
    else
      puts "done. Visit https://github.com/#{$github_username}/#{$projectname} "
    end
  end  
  
  
    
  # git_status
  #
  desc 'git status'
  task :git_status do
    if Hoe::WINDOZE
      sh "git status "
      sh "chcp 65001 > NUL "
    else
      sh "sudo git status "
    end  
  end        
    
  
  
  # git_add
  #
  desc 'git_add -A'
  task :git_add do
    if Hoe::WINDOZE
      sh "git add -A "
      sh "chcp 65001 > NUL "
    else
      sh "sudo git add -A "
    end    
  end    
    
  
  
  # git_commit
  #
  desc 'git commit -m'
  task :git_commit do
    if Hoe::WINDOZE
      sh 'git commit -m "---" '
      sh "chcp 65001 > NUL "
    else
      sh 'sudo git commit -m "---" '
    end     
  end  


  # git push origin master
  #
  desc 'git_push'
  task :git_push do
    if Hoe::WINDOZE
      sh 'git push origin master '
      sh "chcp 65001 > NUL "
    else
      sh 'sudo git push origin master '
    end     
  end  


  
  # git_publish_docs
  #
  desc 'publish docs to github'
  task :git_publish_docs do
    puts
    puts '------------------------------------------------------------------------------------'
    puts ':git_publish_docs     publish docs to github '
    puts      
  
    # Repository erstellen, wenn nötig
    Dir.chdir '/tmp' do
      sh "git clone https://github.com/#{$github_username}/#{$projectname} " do |ok,res|
        if ok
          Dir.chdir "/tmp/#{$projectname}" do
            sh 'git checkout --orphan gh-pages '
          end          
        end
      end # do sh
    end
    
    # alles löschen
    Dir.chdir "/tmp/#{$projectname}" do 
      sh 'git rm -rf --ignore-unmatch . '
    end    
    
    # doc rüberkopieren 
    Dir.chdir 'doc' do
      sh "xcopy /E *.* \tmp\#{$projectname} "
    end      
    
    # publish   
    Dir.chdir "/tmp/#{$projectname}" do
      sh 'git add -A '    
      sh "git commit " + ' -m "---" --allow-empty'
      sh 'git push origin +gh-pages '  # C:\Users\Klippstein\_netrc enthält die Login-Daten
      
      if Hoe::WINDOZE
        sh "start http://#{$github_username}.github.com/#{$projectname} "
      else
        puts "done. Visit http://#{$github_username}.github.com/#{$projectname} "
      end # if   
    
    end # do chdir   
    
        
  end # do task
    
    

  
# -------------------------------------------------------------------------------------------------------
# rubygems
#  

  
  # Task :rubygems_publish
  #
  desc 'release actual version to rubygems'
  task :rubygems_publish  do
    puts
    puts '------------------------------------------------------------------------------------'
    puts ':rubygems_publish     release actual version to rubygems'
    puts  
    ENV["VERSION"] = $projectname.to_class.const_get('VERSION')
    Rake::Task[:release].invoke

  end  


  
  # Task :gem_uninstall
  #
  desc 'uninstall old gem'
  task :gem_uninstall do
    puts
    puts '------------------------------------------------------------------------------------'
    puts ':gem_uninstall        uninstall old gem'
    puts    
    sh "#{'sudo ' unless Hoe::WINDOZE }gem uninstall #{$projectname} --a --ignore-dependencies "
  end  
  

  
  # Task :gem_install
  #
  desc 'install gem from rubygems'
  task :gem_install do
    puts
    puts '------------------------------------------------------------------------------------'
    puts ':gem_install          install gem from rubygems'
    puts     
    sh "#{'sudo ' unless Hoe::WINDOZE }gem install #{$projectname} "
  end    
  
  
  
  
#  ----------------------------------------------------------------------------------------------
#  Documentation
#  
# http://rubeh.tumblr.com/post/27622544/rake-rdoctask-with-all-of-the-options-stubbed-out
# http://www.java2s.com/Code/Ruby/Language-Basics/RDocoptionsareusedlikethisrdocoptionsnames.htm
#   

remove_task 'docs' 

desc "generate RDoc documentation"
Rake::RDocTask.new(:docs) do |rd|

    # puts
    # puts '------------------------------------------------------------------------------------'
    # puts ':docs                 generate RDoc documentation'
    # puts
    rd.title    = "#{$projectname.capitalize} #{$projectname.to_class.const_get('VERSION')}"

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
Dir['tasks/**/*.rake'].each { |t| load t }  
  
  
  
# -------------------------------------------------------------------------------------------------------
# Div
#    
  
    # namespace :manifest do
    # desc 'Recreate Manifest.txt to include ALL files'
    # task :refresh do
      # `rake check_manifest | patch -p0 > Manifest.txt`
    # end
  # end



