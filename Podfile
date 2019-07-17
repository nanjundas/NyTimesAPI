platform :ios, '12.0'
use_frameworks!

workspace 'NYTimes'

project 'NYTimesApp/NYTimesApp.xcodeproj'
project 'NYTimesCore/NYTimesCore.xcodeproj'

target 'NYTimesApp' do
    
    pod 'IGListKit'
    pod 'RealmSwift'
    
    project 'NYTimesApp/NYTimesApp.xcodeproj'
end

target 'NYTimesCore’ do
    
    pod 'RealmSwift'

    project 'NYTimesCore/NYTimesCore.xcodeproj'
end

target 'NYTimesCoreTests’ do

    pod 'RealmSwift'

    project 'NYTimesCore/NYTimesCore.xcodeproj'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5'
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
        end
    end
end
