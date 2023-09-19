# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'JWPlayerBGTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for JWPlayerBGTest
  pod 'JWPlayerKit', '~> 4'
end

post_install do |installer|
  puts 'Setting ONLY_ACTIVE_ARCH = NO for all Pods in Project'
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # The ONLY_ACTIVE_ARCH setting can be removed from here when Google frameworks get upgraded.
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end

