require 'spec'
require 'spec/rake/spectask'
require 'rake'

task :default => :spec

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ["--colour", "--format progress", "--loadby mtime", "--reverse"]
  t.spec_files = FileList[ 'spec/**/*_spec.rb', 'val-ipng/spec/**/*_spec.rb',
                           'val-compact/spec/**/*_spec.rb', 'val-expand/spec/**/*_spec.rb',
                           'val-to-binary/spec/**/*_spec.rb' ]
end

