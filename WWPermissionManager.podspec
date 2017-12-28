

Pod::Spec.new do |s|
s.name = 'WWPermissionManager'
s.version = '0.1'
s.license = 'MIT'
s.summary = 'WWPermissionManager can action permissions'
s.homepage = 'https://github.com/WangWei1993'
s.authors = { 'WangWei1993' => '605479355@qq.com' }
s.source = { :git => 'https://github.com/WangWei1993/PermissionManager.git', :tag => 'v0.3' }

s.ios.deployment_target = '8.0'

s.source_files = 'WWRequestPermission/WWPermissionManager/*.swift'
end
