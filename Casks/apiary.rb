# Cask template: rendered by the homebrew job in .github/workflows/release.yml
# (placeholder tokens replaced with the released version + artifact sha256s)
# and pushed as the full Casks/apiary.rb to rprtr258/homebrew-tap.
cask "apiary" do
  name "apiary"
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.14"
  sha256 arm:          "c4b2c88966694354d0ca42a24547a15efa9900c9b5af2d34adb0ff1972891029",
         intel:        "0f086b8708fc009e1baa5ea99128d91bc7fcfd991a1e9f559091b833ed629cdb",
         x86_64_linux: "93e37e7ed69363c0eb1056dcfea674223ce0c815f845f17b8e8b530c719c07c3"
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
