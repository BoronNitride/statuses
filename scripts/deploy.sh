#!/usr/bin/env ruby
puts "Compiling & creating main jar."
if system('lein uberjar')
  mainjar = Dir['target/statuses-*-standalone.jar'].last
  mainjar['target/'] = '' # and I actually considered this language beautiful once?
  puts "Creating run script for #{mainjar}."
  f = File.new('./run.sh', 'w+')
  f.puts "java -jar #{mainjar}"
  f.close
  puts "Synchronizing with remote dir."
  `rsync --exclude data --delete -avz run.sh target/#{mainjar} public internal2.innoq.com:/home/statuses`
  puts "Done."
end

