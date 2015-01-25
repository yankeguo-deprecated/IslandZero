# Extend Sanitize 2.x with STRICT, filter out any elements
class Sanitize
  module Config
    STRICT = {
      :elements => %w[]
    }
  end
end

# Extend ActionController::Parameters with sanitize
class ActionController::Parameters
  def clean_strict(*keys)
    keys.flatten.compact.each do |key|
      if self[key].present?
        self[key] = Sanitize.clean(self[key], Sanitize::Config::STRICT)
      end
    end
    self
  end
  def clean_basic(*keys)
    keys.flatten.compact.each do |key|
      if self[key].present?
        self[key] = Sanitize.clean(self[key], Sanitize::Config::BASIC)
      end
    end
    self
  end
end

# Extend String with to_bool
class String
  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end

# Extend NilClass with to_bool
class NilClass
  def to_bool
    false
  end
end
