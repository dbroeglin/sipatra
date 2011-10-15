require 'rake/clean'
require 'fileutils'
require 'rspec/core/rake_task'
require 'rexml/document'
require "bundler/gem_tasks"

Dir["./lib/tasks/*.rake"].each { |f| load f }

RSpec::Core::RakeTask.new(:spec)

desc "Run all examples using rcov"
RSpec::Core::RakeTask.new :rcov => :cleanup_rcov_files do |t|
    t.rcov = true
    t.rcov_opts =  %[-Ilib -Ispec --exclude "spec/*,gems/*" --text-report --sort coverage --aggregate coverage.data]
  end
  task :cleanup_rcov_files do
  rm_rf 'coverage.data'
end
task :default => :spec
task :spec 

task :clean do
  rm_rf Dir["lib/sipatra", "lib/sipatra.rb", "target"]
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

# TODO: DRY this up with gemspec
sipatra_jar_version = File::open("pom.xml") do |f|
  REXML::Document::new(f).elements["project/version"].text
end
sipatra_package_name  = "sipatra-#{sipatra_jar_version}"
sipatra_jar_name   = "#{sipatra_package_name}.jar"
sipatra_jar_fullname   = "lib/sipatra/#{sipatra_jar_name}"

file sipatra_jar_fullname => "target/gem-dist/#{sipatra_jar_name}" do
  mkdir_p "lib/sipatra"
  cp_r Dir["src/main/resources/sipatra*"], "lib"
  cp Dir["target/gem-dist/*"].delete_if {|n| n =~ /^jruby-complete/ }, "lib/sipatra"
end

file "target/gem-dist/#{sipatra_jar_name}" => FileList["src/main/**/*"] do
  system "mvn -o package"
end

task :build => sipatra_jar_fullname 
