$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "thecore_download_documents/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "thecore_download_documents"
  spec.version     = ThecoreDownloadDocuments::VERSION
  spec.authors     = ["Gabriele Tassoni"]
  spec.email       = ["gabriele.tassoni@gmail.com"]
  spec.homepage    = "https://github.com/gabrieletassoni/thecore_download_documents"
  spec.summary     = "Common methods to help exporting to csv, pdf documents."
  spec.description = "Some helper methods to create pdfs and csvs ina a simple, tabellar notation. for PDF you can also add an header and a footer to each page."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "thecore_ui_commons", "~> 2.0"
  spec.add_dependency "prawn", "~> 2.2"
  spec.add_dependency "prawn-table", "~> 0.2"
end
