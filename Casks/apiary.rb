# Cask template: rendered by the homebrew job in .github/workflows/release.yml
# (placeholder tokens replaced with the released version + artifact sha256s)
# and pushed as the full Casks/apiary.rb to rprtr258/homebrew-tap.
cask "apiary" do
  name "apiary"
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.10"
  sha256 arm:          "801b8733b858ad108b4c460c3dd4cee2a9c6f52f30c054783c44e6c4298b813c",
         intel:        "b99f709874783553cc35aab25dc21ba2cdac750c112aa722c0078da90b534b27",
         x86_64_linux: "97bd49d2d132d2274012d6c1c7c41ea9c16c92639bff2cad1ce5ae02d486b93c"
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
