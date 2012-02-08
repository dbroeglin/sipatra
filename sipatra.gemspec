# -*- encoding: utf-8 -*-
require 'rexml/document'
$:.push File.expand_path("../lib", __FILE__)

sipatra_jar_version = File::open("pom.xml") do |f|
  REXML::Document::new(f).elements["project/version"].text
end
sipatra_package_name  = "sipatra-#{sipatra_jar_version}"
sipatra_jar_name      = "#{sipatra_package_name}.jar"

sipatra_gem_files     = Dir["src/main/resources/**/*.rb"].to_a.map do |file|
  file.gsub(%r{src/main/resources}, "lib")
end  
sipatra_gem_files.concat Dir["lib/sipatra/*"] 
sipatra_gem_files << "lib/sipatra.rb"
sipatra_gem_files << "lib/sipatra/#{sipatra_jar_name}" 
sipatra_gem_files << "lib/sipatra-jars.rb"


sipatra_version = sipatra_jar_version.gsub(/-SNAPSHOT/, '')

Gem::Specification.new do |s|
  s.name        = "sipatra"
  s.version     = sipatra_version
  s.authors     = ["Dominique Broeglin", "Jean-Baptiste Morin"]
  s.email       = ["dominique.broeglin@gmail.com", "jean-baptiste.morin@nexcom.fr"]
  s.homepage    = "http://confluence.cipango.org/display/DOC/Sipatra"
  s.summary     = %q{DSL for easy writting of SIP Servlet applications}
  s.description = %q{Sipatra is a Ruby DSL for easy writting of SIP Servlet applications}

  s.rubyforge_project = "sipatra"

  #s.files         = `git ls-files`.split("\n")
  s.files         = sipatra_gem_files
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n").select { |filename|
  %r{test/integration/sipapp/WEB-INF/(lib|classes)} !~ filename
}

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "vagrant", "~> 0.9.6"
end
