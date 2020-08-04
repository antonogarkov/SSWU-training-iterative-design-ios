inhibit_all_warnings!
use_frameworks!
platform :ios, '12.0'
workspace 'farm.xcworkspace'

def common
  pod 'SkyFloatingLabelTextField', '3.7.0'
  pod 'IQKeyboardManagerSwift', '6.5.5'
  pod 'Kingfisher', '5.8.3'
end

target 'UI' do
  project 'UI/UI.xcodeproj'

  common
end

target 'farm' do
   project 'farm.xcodeproj'

   common
end

target 'StorybookApp' do
  project 'farm.xcodeproj'

  common
end

target 'StorybookAppUITests' do
  project 'farm.xcodeproj'

  common
end
