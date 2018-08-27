

Pod::Spec.new do |s|
s.name = 'PermissionManager'
s.version = '0.5.6'
s.license = 'MIT'
s.summary = 'PermissionManager can action permissions'
s.homepage = 'https://github.com/WangWei1993'
s.authors = { 'WangWei1993' => '605479355@qq.com' }
s.source = { :git => 'https://github.com/wangweilucky/PermissionManager.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'WWRequestPermission/WWPermissionManager/*.swift'
end
