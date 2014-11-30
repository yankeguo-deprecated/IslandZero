# Extend ActionController::Parameters with sanitize
class ActionController::Parameters
  def clean_strict(*keys)
    keys.flatten.compact.each do |key|
      if self[key].present?
        self[key] = Sanitize.clean(self[key], Sanitize::Config::RESTRICTED)
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
