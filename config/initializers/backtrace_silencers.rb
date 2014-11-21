Rails.backtrace_cleaner.add_filter   { |line| line.gsub(Rails.root, '') }   # strip the Rails.root prefix
Rails.backtrace_cleaner.add_silencer { |line| line =~ /mongrel|rubygems/ }  # skip any lines from mongrel or rubygems
