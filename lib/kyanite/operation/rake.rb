# ruby encoding: utf-8

#== *Rake* 
#Beispiele siehe Rakefile.rb
#* Methode remove_task, um Tasks überschreiben zu können


#  ----------------------------------------------------------------------------------------------
#  Rake initialisieren
#  

require 'rake'
#require 'rake/testtask'


  

#   ----------------------------------------------------------------------------------------------
#   Ergänzung: Alte Tasks entfernen
#   sonst kann man sie nämlich nicht überschreiben!
#   Beispiel: remove_task 'test:plugins'     
#   Quelle: http://matthewbass.com/2007/03/07/overriding-existing-rake-tasks/
#   dies hier stimmt nicht: http://www.dcmanges.com/blog/modifying-rake-tasks
   
Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end




# Task :sleep_5
#
desc 'Sleep 5 seconds'
task :sleep_5 do
  puts 
  puts 
  puts 
  if Hoe::WINDOZE
    sh "wait 5"
  else
    sh "sleep 5"
  end
  #puts '---------------------------------------------------'
end


# Task :sleep_15
#
desc 'Sleep 15 seconds'
task :sleep_15 do
  puts 
  puts 
  puts 
  if Hoe::WINDOZE
    sh "wait 15"
  else
    sh "sleep 15"
  end
  #puts '---------------------------------------------------'
end



  

