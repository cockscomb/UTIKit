Pod::Spec.new do |s|

  s.name         = "UTIKit"
  s.version      = "2.0.0"
  s.summary      = "UTIKit is an UTI (Uniform Type Identifier) wrapper for Swift."

  s.description  = <<-DESC
                   UTIKit is a full featured library including entire UTI functions.

                   * Convertibility
                     * Filename extension
                     * MIME type
                     * OSType (OS X only)
                     * Pasteboard type (OS X only)
                   * Equality
                   * Conformance
                   * and others…
                   DESC

  s.homepage     = "https://github.com/cockscomb/UTIKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Hiroki Kato" => "mail@cockscomb.info" }
  s.social_media_url   = "http://twitter.com/cockscomb"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"

  s.source       = { :git => "https://github.com/cockscomb/UTIKit.git", :tag => "#{s.version}" }
  s.source_files = "UTIKit/**/*.swift"

  s.requires_arc = true

end
