Pod::Spec.new do |s|
  s.name         = "HSNavigationBar"

  s.version      = "1.0.0"

  s.summary      = "custom navigation bar."

  s.homepage     = "https://github.com/ZYXiao/HSNavigationBar"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "ZYXiao" => "304983615@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ZYXiao/HSNavigationBar.git", :tag => "1.0.0" }

  s.source_files  = "HSNavigationBar/*.{h,m}"

  s.frameworks    = 'UIKit'

  s.dependency 'Masonry'

  s.requires_arc = true
end
