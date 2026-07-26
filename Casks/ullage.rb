# Homebrew cask for Ullage.
#
# Install:
#
#     brew install --cask fr1eddy/ullage/ullage
#
cask "ullage" do
  version "0.1.0"
  sha256 "1a4f26d4f2242ed8ddccc9baa0755c6692f8151e72685544f7715c63424bd974"

  url "https://github.com/FR1EDDY/Ullage/releases/download/v#{version}/Ullage-#{version}.dmg"
  name "Ullage"
  desc "Menu-bar usage and cost tracking for Claude and Cursor"
  homepage "https://github.com/FR1EDDY/Ullage"

  depends_on macos: :ventura

  app "Ullage.app"

  # This build is ad-hoc signed rather than notarised, so Gatekeeper quarantines
  # it on download. Homebrew strips the quarantine attribute for casks it
  # installs, which is why `brew install` needs no right-click dance while a
  # manual DMG download does.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ullage.app"],
                   sudo: false
  end

  uninstall quit: "com.ullage.app"

  zap trash: [
    "~/Library/Application Support/Ullage",
    "~/Library/Preferences/com.ullage.app.plist",
    "~/Library/Caches/com.ullage.app",
  ]
end
