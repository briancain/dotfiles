require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install, [:options] do |t,args|
  install_mutt = false
  unless args.nil?
    if args['options'].eql? 'mutt'
      install_mutt = true
    end
  end

  replace_all = false

  Dir['*'].each do |file|
    unless install_mutt
      next if %w[Rakefile update-zsh.sh readme.md LICENSE install.sh mutt-colors-solarized mutt muttrc.erb].include? file
    else
      next if %w[Rakefile update-zsh.sh readme.md LICENSE install.sh mutt-colors-solarized].include? file
    end

    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
