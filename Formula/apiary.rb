class Apiary < Formula
  desc "Desktop app for managing API requests"
  homepage "https://github.com/rprtr258/apiary"
  version "0.0.8"
  url "https://github.com/rprtr258/apiary/releases/download/v#{version}/apiary-linux-x86_64.AppImage"
  sha256 "f91a22f910bf06c21a7b3d3e612e6653d81c2e634966f4a1dcb218ad4ae535e0"

  depends_on :linux
  depends_on arch: :x86_64

  def install
    # Extract at install time: no FUSE needed at runtime, no temp extraction per launch.
    chmod 0755, "apiary-linux-x86_64.AppImage"
    system "./apiary-linux-x86_64.AppImage", "--appimage-extract"
    libexec.install "squashfs-root" => "app"
    (bin/"apiary").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/app/AppRun" "$@"
    EOS
    chmod 0755, bin/"apiary"
  end

  test do
    # App is a GUI; verify the installed tree is intact and launcher resolves.
    assert_path_exists libexec/"app/AppRun"
    assert_predicate bin/"apiary", :executable?
  end
end
