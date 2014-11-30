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
