Pod::Spec.new do |spec|

  spec.name         = "TBGrowingTextView"
  spec.version      = "0.1.4"
  spec.summary      = "TBGrowingTextView is a text view which grows with the text changes and starts scrolling when the content reaches a specified number of lines."

  spec.homepage     = "https://github.com/teambition/GrowingTextView"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "bruce" => "liangmingzou@163.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/teambition/GrowingTextView.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"

  spec.source_files  = "GrowingTextView/*.swift"
  spec.frameworks   = "Foundation", "UIKit"

end