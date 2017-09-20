# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Configure JBuilder to produce output with keys in camelCase
Jbuilder.key_format camelize: :lower

