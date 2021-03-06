##############################################################################
#                             CarrierWave Plugin
##############################################################################

begin
  require 'carrierwave'
  require 'carrierwave/test/matchers'

  RSpec.configure do |config|
    config.include CarrierWave::Test::Matchers, :file_attachment => true
  end

  CarrierWave.configure do |config|
    config.storage           = :file
    config.root              = File.expand_path('./tmp')
    config.enable_processing = false
  end

  RSpec.configure do |config|
    config.around(:each, :file_attachment => true) do |example|
      previous_carrierwave_processing_mode = subject.class.enable_processing
      subject.class.enable_processing = true

      example.run

      subject.class.enable_processing = previous_carrierwave_processing_mode
    end
  end
rescue LoadError
end
