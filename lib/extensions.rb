# Extend ActionController::Parameters with sanitize
class ActionController::Parameters
  def clean(*keys)
    keys.flatten.compact.each do |key|
      if self[key].present?
        self[key] = Sanitize.clean(self[key], Sanitize::Config::RESTRICTED)
      end
    end
    self
  end
end
