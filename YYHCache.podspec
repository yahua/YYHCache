
Pod::Spec.new do |s|


  s.name         = "YYHCache"
  s.version      = "0.0.6"
  s.summary      = "data of Cache"
  s.description  = <<-DESC
                   Memory cache disk cache.
                   DESC

  s.homepage     = "https://github.com/yahua/YYHCache"
  s.license      = "MIT"
  s.author       = { "yahua" => "yahua523@163.com" }

  s.platform     = :ios, "7.0"
  s.requires_arc = true


  s.source       = { :git => "https://github.com/yahua/YYHCache.git", :tag => "0.0.6" }


  s.source_files  = "YYHCache/*.{h,m}"
  s.frameworks = "Foundation", "UIKit"



end
