# frozen_string_literal: true

# Overrides zeitwerk default inflections
Rails.autoloaders.each do |autoloader|
  autoloader.inflector = Zeitwerk::Inflector.new

  # Specifies the rule to be applied when it camelizes the file names into constant names
  autoloader.inflector.inflect(
    'json_with_status_adapter' => 'JSONWithStatusAdapter'
  )
end
