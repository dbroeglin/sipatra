begin
  require 'vagrant'

  def exec!(*commands)
    env = Vagrant::Environment::new
    env.primary_vm.channel.execute commands do |type, data|
      puts "#{type == :stdout ? "\e[32m" : "\e[33m"}#{data}\e[0m"
    end
  end

  namespace :test do
    namespace :cipango do
      desc "Start Cipango test server"
      task :start do
        exec! "cd /cipango; PATH=/sbin:$PATH bin/jetty.sh start"
      end

      desc "Stop Cipango test server"
      task :stop do
        exec! "cd /cipango; bin/jetty.sh stop"
      end
    end

    desc "Run integration tests"
    task :integration do
      exec! "pwd"
    end
  end
rescue LoadError
  puts "WARNING: Vagrant is not available. In order to run vagrant tasks, you must: gem install vagrant"
end

