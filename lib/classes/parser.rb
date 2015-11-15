require 'JSON'
class Parser
  def self.parse(to_parse)
    return JSON.parse(to_parse)
  end
end