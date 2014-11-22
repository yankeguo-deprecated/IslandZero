# Extend Sanitize with cleaning hash values
class Sanitize
  def self.clean_hash(hash, config)
    hash.each { |key, value| hash[key] = self.clean value, config }
  end
end
