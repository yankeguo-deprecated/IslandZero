Rails.backtrace_cleaner.add_filter   { |line| line.gsub(Rails.root.to_s, '') }          # strip the Rails.root prefix
Rails.backtrace_cleaner.add_silencer { |line| line =~ /mongrel|rubygems|gems/i }  # skip any lines from mongrel or rubygems
