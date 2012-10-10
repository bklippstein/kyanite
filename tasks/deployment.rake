# ruby encoding: utf-8
# ü


    
    

  
  


# ---------------------------------------------------------
# div
#

  # Task :deploy
  #
  desc 'Uninstall gem, release, reinstall gem'
  task :deploy => [ :release_now, :gem_uninstall, :sleep_15, :gem_install] do
    puts 'done.'
  end  

  
  
  # Task :release_now
  #
  desc 'release actual version'
  task :release_now  do
    ENV["VERSION"] = Kyanite::VERSION
    Rake::Task[:release].invoke

  end  


  
  # Task :gem_uninstall
  #
  desc 'Uninstall gem'
  task :gem_uninstall do
    sh "#{'sudo ' unless Hoe::WINDOZE }gem uninstall kyanite --a --ignore-dependencies"
  end  
  

  
  # Task :gem_install
  #
  desc 'Install gem from remote'
  task :gem_install do
    sh "#{'sudo ' unless Hoe::WINDOZE }gem install kyanite"
  end    
  
  
  
  
  

  


  
  
  # Task :deploy 
  # alles auf einmal
  #  
  # desc 'publish_docs, release, post_news'
  # task :deploy => [:publish_docs, :sleep_5, :release, :sleep_5, :post_news, :sleep_5 ] do
    # puts 
    # puts "#{$hoe.name}-#{Kyanite::VERSION} deployed."
    # puts "Check at http://#{$hoe.rubyforge_name}.rubyforge.org"
    # puts "Remember to create SVN tag:"
    # puts "svn copy svn+ssh://#{rubyforge_username}@rubyforge.org/var/svn/#{PATH}/trunk " +
      # "svn+ssh://#{rubyforge_username}@rubyforge.org/var/svn/#{PATH}/tags/REL-#{VERS} "
    # puts "Suggested comment:"
    # puts "Tagging release #{CHANGES}"
 # end




  # namespace :manifest do
    # desc 'Recreate Manifest.txt to include ALL files'
    # task :refresh do
      # `rake check_manifest | patch -p0 > Manifest.txt`
    # end
  # end
  
  
