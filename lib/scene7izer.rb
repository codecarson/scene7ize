require "scene7izer/version"

module Scene7izer
  DEFAULT_REGEX = /[\.\.\/]*images\/(.*)(jpg|png|gif)(?=['")])/i

  def self.filename_from_string(string_to_match)
    filename = DEFAULT_REGEX.match(string_to_match)
    filename.to_s unless filename.nil?
  end
end
