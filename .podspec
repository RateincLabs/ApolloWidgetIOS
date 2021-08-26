Pod::Spec.new do |s|  
    s.name = 'ApolloWidget'
    s.version = '0.0.1'
    s.summary = 'ApolloWidget IOS SDK'
    s.homepage = 'https://www.rateinc.cl/'

    s.author = { 'Rateinc' => 'servidores@rateinc.cl' }
    s.license = { :type => 'MIT', :file => 'LICENSE' }

    s.platform = :ios
    s.source = { :git => 'https://github.com/RateincLabs/ApolloWidgetIOS.git', tag => '0.0.1' }
    s.ios.deployment_target = '9.0'
    s.ios.vendored_frameworks = 'ApolloWidget.framework'
    s.dependency 'MaterialComponents/BottomSheet'
end