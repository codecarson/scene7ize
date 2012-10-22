require "scene7izer/version"

module Scene7izer
  DEFAULT_REGEX = /[\.\.\/]*images\/(.*)(jpg|png|gif)['")]/

  def self.match(string_to_match)
    DEFAULT_REGEX.match(string_to_match)
  end
end
