require 'support/helpers/session_helpers'
require 'support/helpers/media_item_helpers'

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::MediaItemHelpers, type: :feature
end
