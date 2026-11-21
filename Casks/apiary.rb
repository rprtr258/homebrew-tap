# Cask template: rendered by the homebrew job in .github/workflows/release.yml
# (placeholder tokens replaced with the released version + artifact sha256s)
# and pushed as the full Casks/apiary.rb to rprtr258/homebrew-tap.
cask "apiary" do
  name "apiary"
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.15"
  sha256 arm:          "f06a846820cce53ed93888323d1859f761bc40f868b23acf07422b971c07ef89",
         intel:        "b803f40dfa69919ab602602fcf7708b1d698889c00eda447cacce97436cbd38e",
         x86_64_linux: "facfc358f343be74d5c01a0437a8cc154bf2d59bc6692bd2417a568b15465283"
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
