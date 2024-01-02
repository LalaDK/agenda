Gem::Specification.new do |spec|
  spec.name          = "Agenda"
  spec.version       = "0.1.0"
  spec.authors       = ["Mads"]
  spec.email         = ["mads.eckardt@gmail.com"]
  spec.summary       = "A brief summary of your project"
  spec.description   = "A longer description of your project"
  spec.homepage      = "https://github.com/your_username/my_project"
  spec.license       = "MIT"
  spec.files         = Dir["{bin,lib,example}/**/*"]
  spec.require_paths = ["lib"]
  spec.add_dependency "icalendar", "~> 2.8"
  spec.add_dependency "icalendar-recurrence", "~> 1.1"
  spec.executables = "agenda"
end

