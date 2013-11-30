Pod::Spec.new do |s|
  s.name         = "DVParallaxView"
  s.version      = "0.1.0"
  s.summary      = "A subclass of UIView, that apply parallax effect on its subviews"
  s.homepage     = "https://github.com/denivip/DVParallaxView"
  s.license      = 'MIT'
  s.author       = { "Mikhail Grushin" => "grushin@denivip.ru" }
  s.source       = { :git => "https://github.com/denivip/DVParallaxView"}
  s.platform     = :ios, '>=5.0'
  s.ios.deployment_target = '5.0'
  s.source_files = 'DVParallaxView'
  s.ios.framework = 'CoreMotion'
  s.requires_arc = true
end
