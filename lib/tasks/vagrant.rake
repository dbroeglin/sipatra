begin
  require 'vagrant'

  namespace :test do
    namespace :cipango do
      def exec!(command)
        command = command.join("; \\\n") if command.respond_to? :each
        @vagrant_env.primary_vm.channel.execute command do |type, data|
          puts "#{type == :stdout ? "\e[32m" : "\e[33m"}#{data}\e[0m"
        end
      end

      task :prep do
        @vagrant_env = Vagrant::Environment::new
      end

      desc "Start Cipango test server"
      task :start => :prep do
        if @vagrant_env.primary_vm.state != :running
          @vagrant_env.cli "up"
        end
        exec! [
          "cd /cipango",
          "chmod +x bin/jetty.sh",
          "rm -rf webapps/* sipapps/* contexts/{test,javadoc}.xml",
          "echo --ini=start-cipango.ini     > etc/jetty.conf",
          "echo --pre=etc/cipango-jmx.xml   >> etc/jetty.conf",
          "echo --pre=etc/jetty-logging.xml >> etc/jetty.conf",
          "PATH=/sbin:$PATH bin/jetty.sh start",
        ]
      end

      desc "Stop Cipango test server"
      task :stop => :prep do
        raise "Test VM must be running to stop Cipango" if @vagrant_env.primary_vm.state != :running
        exec! [
          "cd /cipango",
          "chmod +x bin/jetty.sh",
          "bin/jetty.sh stop"
        ]
      end

      desc "Deploy the integration test app"
      task :deploy => :prep do
        if @vagrant_env.primary_vm.state != :running
          Rake::Task[:start].invoke
        end
        exec! "cp /vagrant/test/integration/sipatra.xml /cipango/contexts/"
      end

      desc "Download and setup cipango for integration testing"
      task :setup do
        sh "curl -sS http://cipango.googlecode.com/files/cipango-distribution-2.0.0.tar.gz | tar zxv -C .."
      end
    end

    desc "Run integration tests"
    task :integration do
    end

  end
rescue LoadError
  puts <<EOF
WARNING: Vagrant is not available.
In order to run vagrant tasks, you must: gem install vagrant"
EOF
end

