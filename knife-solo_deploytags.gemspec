Gem::Specification.new do |s|
  s.name = "knife-solo_deploytags"
  s.version = "0.0.1"
  s.summary = "Tags deploys of chef repo to nodes via knife solo cook"
  s.author = "Mark Woods"
  s.homepage = "https://github.com/thickpaddy/knife-solo_deploytags"
  s.files = `git ls-files`.split("\n")

  s.add_dependency "knife-solo_hooks"
end
