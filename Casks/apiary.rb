# Cask template: rendered by the homebrew job in .github/workflows/release.yml
# (placeholder tokens replaced with the released version + artifact sha256s)
# and pushed as the full Casks/apiary.rb to rprtr258/homebrew-tap.
cask "apiary" do
  name "apiary"
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.12"
  sha256 arm:          "58dc00b546424580d72d4db1da6774fe304af5ca87fe42e28d95b16e2532f325",
         intel:        "74e30a943847686c0091975923095d284c35e44b5778dbbba2c5d894283f236b",
         x86_64_linux: "7160364c9f4305754d3a1baf1d28b730d2a6dc2181cf4d061d253743704c7f81"
  arch arm: "darwin-arm64", intel: on_system_conditional(macos: "darwin-x64", linux: "linux-x86_64")
  os macos: "dmg", linux: "AppImage"
  url "https://github.com/rprtr258/apiary/releases/download/v#{version}/apiary-#{arch}.#{os}"

  on_macos do
    app "apiary.app"

    zap trash: [
      "~/Library/Application Support/apiary",
      "~/Library/Caches/com.apiary.app",
      "~/Library/Preferences/com.apiary.app.plist",
      "~/Library/Saved Application State/com.apiary.app.savedState",
    ]
  end
  on_linux do
    app_image "apiary-#{arch}.AppImage", target: "apiary.AppImage"
  end

  livecheck do
    url :url
    strategy :github_latest
  end
end
