Gem::Specification.new do |s|
  s.name     = "acts_as_xapian"
  s.version  = "1.9.3"
  s.date     = "2015-02-13"
  s.summary  = "acts_as_xapian adds support for Xapian to Rails and Ruby 1.9 and above"
  s.email    = "para.alves@gmail.com"
  s.homepage = "https://github.com/altherlex/acts_as_xapian"
  s.description = "acts_as_xapian adds support for Xapian to Rails and Ruby 1.9 and above"
  #s.has_rdoc = true
  s.authors  = ["Francis from Mysociety","Alther"]
  #s.autorequire       = ["pdf/writer"]
  s.require_paths     = ["lib"]
  s.bindir            = "bin"
  #s.executables       = ["techbook"]
  #s.add_dependency('color', '>= 1.4.0')
  #s.add_dependency('transaction-simple', '~> 1.3')             
  s.files       = Dir["lib/**/*"]
  #s.rdoc_options = ["--title", "PDF::Writer", "--main", "README", "--line-numbers"]
  #s.extra_rdoc_files = ["README", "ChangeLog", "LICENCE"]
end