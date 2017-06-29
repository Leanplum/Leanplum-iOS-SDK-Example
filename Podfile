LP_VERSION = ENV['LP_VERSION'] ? ENV['LP_VERSION'] : '2.0.1'
DEPLOYMENT_TARGET = ENV['LP_STATIC'] ? '6.0' : '8.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Leanplum/CocoaPods.git'

target 'Leanplum-iOS-SDK-Example' do
    platform :ios, DEPLOYMENT_TARGET
    if ENV['LP_SOURCES']
        if ENV['LP_STATIC']
            print("Installing Leanplum using SOURCES/STATIC\n")
            else
            print("Installing Leanplum using SOURCES/DYNAMIC\n")
            use_frameworks!
        end
        pod 'Leanplum-iOS-SDK-source', :path => '../Leanplum-iOS-SDK/'
        pod 'Leanplum-iOS-Location-source', :path => '../Leanplum-iOS-Location'
        pod 'Leanplum-iOS-UIEditor', :path => '../Leanplum-iOS-UIEditor-source'
        else
        if ENV['LP_STATIC']
            print("Installing Leanplum using PACKAGED/STATIC\n")
            pod 'Leanplum-iOS-SDK-static', '= ' + LP_VERSION
            pod 'Leanplum-iOS-Location-static', '= ' + LP_VERSION
            pod 'Leanplum-iOS-UIEditor-static', '= ' + LP_VERSION
            else
            print("Installing Leanplum using PACKAGED/DYNAMIC\n")
            use_frameworks!
            pod 'Leanplum-iOS-SDK', '= ' + LP_VERSION
            pod 'Leanplum-iOS-Location', '= ' + LP_VERSION
            pod 'Leanplum-iOS-UIEditor', '= ' + LP_VERSION
        end
    end
    
    post_install do |pi|
        pi.aggregate_targets.first.user_project.build_configurations.each do |config|
            print("Setting App Deployment target to: " + DEPLOYMENT_TARGET + "\n")
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
            if ENV['LP_STATIC'] and ENV['LP_SOURCES']
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'STATIC=1'
                elsif config.build_settings['GCC_PREPROCESSOR_DEFINITIONS']
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'].clear
            end
        end
        pi.aggregate_targets.first.user_project.save
        
        pi.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                print("Setting Pod Deployment target to: " + DEPLOYMENT_TARGET + "\n")
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
            end
        end
    end
end

