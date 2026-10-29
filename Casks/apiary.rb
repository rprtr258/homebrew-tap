# Cask template: rendered by the homebrew job in .github/workflows/release.yml
# (placeholder tokens replaced with the released version + artifact sha256s)
# and pushed as the full Casks/apiary.rb to rprtr258/homebrew-tap.
cask "apiary" do
  url "https://github.com/rprtr258/apiary/releases/download/v#{version}/apiary-#{arch}.#{os}"
  name "apiary"
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.10"
  sha256 arm:          "cbf60648804fd42ec95ac556f2e393f8332271c0d59d54aa952c3934d530fb36",
         intel:        "c1e5b5808f836d2c5a208b14be061d64a019d96026e166aa1dc124d2250de420",
         x86_64_linux: "9ea9f2dbe41e1d93886bca3646719ac576a26ade89992891f58764bd8256b2ec"

  arch arm: "darwin-arm64", intel: on_system_conditional(macos: "darwin-x64", linux: "linux-x86_64")
  os macos: "dmg", linux: "AppImage"

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
