Pod::Spec.new do |s|  
    s.name = 'ApolloWidget'
    s.version = '0.0.3'
    s.summary = 'ApolloWidget IOS SDK'
    s.homepage = 'https://www.rateinc.cl/'

    s.author = { 'Rateinc' => 'servidores@rateinc.cl' }
    s.license = { :type => 'MIT', :file => 'LICENSE' }

    s.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.user_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.platform = :ios
    s.source = { :git => 'https://github.com/RateincLabs/ApolloWidgetIOS.git', :tag => '0.0.3' }
    s.ios.deployment_target = '15.2'
    s.ios.vendored_frameworks = 'ApolloWidget.xcframework'
end
