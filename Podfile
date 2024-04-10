 platform :ios, '11.0'

target 'PiggyLists' do

  use_frameworks!

  # Pods for PiggyLists

pod 'RealmSwift'

pod 'SwipeCellKit'

pod 'ChameleonFramework/Swift', :git => 'https://github.com/wowansm/Chameleon.git', :branch => 'swift5'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
        end
    end
end


end
