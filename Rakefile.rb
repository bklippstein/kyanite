# ruby encoding: utf-8

require 'rubygems'
require 'hoe'
require 'rake'
require File.dirname(__FILE__) + '/lib/kyanite'
require 'kyanite/rake'
require 'rdoc/task'








#  ----------------------------------------------------------------------------------------------
#  Documentation
#  
# http://rubeh.tumblr.com/post/27622544/rake-rdoctask-with-all-of-the-options-stubbed-out
# http://www.java2s.com/Code/Ruby/Language-Basics/RDocoptionsareusedlikethisrdocoptionsnames.htm


remove_task 'docs' 

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



#  ----------------------------------------------------------------------------------------------
#  Hoe
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


# -------------------------------------------------------------------------------------------------------
# publish
#

  # Task :publish
  #
  desc 'publish all on github and rubygems, reinstall gem'
  task :publish => [ :docs, :rubygems_publish, :gem_uninstall, :git_publish, :sleep_15, :gem_install] do
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
    puts
    if Hoe::WINDOZE
      sh "start https://github.com/bklippstein/kyanite "
    else
      puts 'done. Visit https://github.com/bklippstein/kyanite'
    end
  end  
  
  
    
  # git_status
  #
  desc 'git status'
  task :git_status do
    sh "#{'sudo ' unless Hoe::WINDOZE }git status "
  end        
    
  
  
  # git_add
  #
  desc 'git_add -A'
  task :git_add do
    sh "#{'sudo ' unless Hoe::WINDOZE }git add -A "
  end    
    
  
  
  # git_commit
  #
  desc 'git commit -m'
  task :git_commit do
    sh "#{'sudo ' unless Hoe::WINDOZE }git commit " + ' -m "---"'
  end  


  # git push origin master
  #
  desc 'git_push'
  task :git_push do
    sh "#{'sudo ' unless Hoe::WINDOZE }git push origin master "
  end  


  # git_publish_docs
  #
  desc 'Update gh-pages branch'
  task :git_publish_docs do
  
    Dir.chdir '/tmp' do
      sh 'git clone https://github.com/bklippstein/kyanite '
    end
    
    Dir.chdir '/tmp/kyanite' do
      sh 'git checkout --orphan gh-pages '
      sh 'git rm -rf . '
    end    
    
    Dir.chdir 'doc' do
      sh 'xcopy /E *.* \tmp\kyanite '
    end      
    
    sh 'git add -A '    
    sh 'git commit -a -m "commit" '    
    sh 'git push origin gh-pages '    
        
  end
    
    
  # git_publish_docs
  #
  desc 'Update gh-pages branch'
  task :git_publish_docs2 do
  
  
  
    # sh "mv doc/*.* /tmp/kyanite " 
    # sh "copy ./doc/* /tmp/kyanite -recurse "   
    #sh "git branch"
    #sh "copy -r doc/* /tmp/kyanite "    
    
  end    
    
    
    
    #sh "ls"   
    #sh "cp -r doc/* /tmp/kyanite"   
      
    

    
    
    
  
    # sh "rm -r /temp-doc "                                              # temporären Ordner entfernen
    # sh "mv ./doc /temp-doc "                                or abort   # temporären Ordner neu erstellen
    # sh "git checkout gh-pages "                             or abort
    # sh "rm -r ./doc "                                       or abort   # lokalen doc-Ordner löschen
    # sh "mv -v /temp-doc/doc . "                             or abort   # 
    # sh "git add . "                                         or abort   # 
    # sh "git commit --all -m 'updating doc and coverage' "   or abort   # 
    # sh "git checkout master "                               or abort   # 
    # sh "git push origin gh-pages "         

# cd /tmp
# git clone https://github.com/bklippstein/kyanite    
    
    
  # system(" set -x; mv -v ./coverage /tmp ") or abort
  # system(" set -x; git checkout gh-pages ") or abort
  # system(" set -x; rm -rf ./doc ./coverage ") or abort
  # system(" set -x; mv -v /tmp/doc . ") or abort
  # system(" set -x; mv -v /tmp/coverage . ") or abort
  # system(" set -x; git add . ") or abort 
  # system(" set -x; git commit --all -m 'updating doc and coverage' ") or abort
  # system(" set -x; git checkout master ") or abort
  # puts "don't forget to run: git push origin gh-pages"    
  
  
    # rev = `git rev-parse --short HEAD`.strip
    # Dir.chdir 'docs' do
      # sh "git add *.html"
      # sh "git commit -m 'rebuild pages from #{rev}'" do |ok,res|
        # if ok
          # verbose { puts "gh-pages updated" }
          # sh "git push -q o HEAD:gh-pages"
        # end
      # end
    # end
    
    




  
  
# -------------------------------------------------------------------------------------------------------
# rubygems
#  

  
  
  # Task :rubygems_publish
  #
  desc 'release actual version'
  task :rubygems_publish  do
    ENV["VERSION"] = Kyanite::VERSION
    Rake::Task[:release].invoke

  end  


  
  # Task :gem_uninstall
  #
  desc 'Uninstall gem'
  task :gem_uninstall do
    sh "#{'sudo ' unless Hoe::WINDOZE }gem uninstall kyanite --a --ignore-dependencies "
  end  
  

  
  # Task :gem_install
  #
  desc 'Install gem from remote'
  task :gem_install do
    sh "#{'sudo ' unless Hoe::WINDOZE }gem install kyanite "
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



