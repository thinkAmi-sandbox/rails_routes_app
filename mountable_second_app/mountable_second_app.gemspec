require_relative "lib/mountable_second_app/version"

Gem::Specification.new do |spec|
  spec.name        = "mountable_second_app"
  spec.version     = MountableSecondApp::VERSION
  spec.authors     = ["thinkAmi"]
  spec.email       = ["dev.thinkami+git@gmail.com"]
  spec.homepage    = "https://thinkami.hatenablog.com/"
  spec.summary     = "Summary of MountableSecondApp."
  spec.description = "Description of MountableSecondApp."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thinkAmi-sandbox"
  spec.metadata["changelog_uri"] = "https://github.com/thinkAmi-sandbox"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3.2"
end
