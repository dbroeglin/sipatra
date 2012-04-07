begin
  require 'vagrant'

  def exec!(env, command)
    env.primary_vm.channel.execute command do |type, data|
      puts "#{type == :stdout ? "\e[32m" : "\e[33m"}#{data}\e[0m"
    end
  end

  namespace :test do
    namespace :cipango do
      desc "Start Cipango test server"
      task :start do
        env = Vagrant::Environment::new
        if env.primary_vm.state != :running
          env.cli "up"
        end
        exec! env, "cd /cipango; PATH=/sbin:$PATH bin/jetty.sh start"
      end

      desc "Stop Cipango test server"
      task :stop do
        env = Vagrant::Environment::new
        raise "Test VM must be running to stop Cipango" if env.primary_vm.state != :running
        exec! env, "cd /cipango; bin/jetty.sh stop"
      end
    end

    desc "Run integration tests"
    task :integration do
      env = Vagrant::Environment::new
      exec! env, "pwd" end
  end
rescue LoadError
  puts "WARNING: Vagrant is not available. In order to run vagrant tasks, you must: gem install vagrant"
end

