platform :ios, '6.0'

target :PocketForecast, :exclusive => true do

  pod 'LRResty'
  pod 'Typhoon'
  pod 'OCLogTemplate'
  pod 'RaptureXML'

end

# Test Dependencies

target :PocketForecastTests do
  pod 'Expecta', '~> 0.2.1'
  pod 'OCHamcrest'
  pod 'OCMockito'
end

post_install do |installer|
  installer.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
    end
  end
end
