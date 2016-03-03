Pod::Spec.new do |s|
  s.name             = "Linqwift"
  s.version          = "0.1.0"
  s.summary          = "Swift language LINQ extension"

  s.description      = <<-DESC
                       Just imagine the power of LINQ on iOS and OS X platforms. 
                       Main objective is to implement all of these methods:
                       http://msdn.microsoft.com/en-us/library/system.linq.enumerable_methods.aspx
                       DESC

  s.homepage         = "https://github.com/k06a/Linqwift"
  s.license          = 'MIT'
  s.author           = { "Anton Bukov" => "k06aaa@gmail.com" }
  s.source           = { :git => "https://github.com/k06a/Linqwift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/k06a'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
