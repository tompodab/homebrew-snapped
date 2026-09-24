cask "snapped" do
  version "0.1.18"
  sha256 "f862032de79ea45b0d1beacc90434cef8a4106b92c460a0fc2d2ab8bfe8391c9"

  url "https://github.com/tompodab/snapped/releases/download/#{version}/Snapped-#{version}.dmg"
  name "Snapped"
  desc "Window manager that snaps windows into hotspots you define"
  homepage "https://github.com/tompodab/snapped"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app moves other applications' windows through the Accessibility API,
  # which a sandboxed process cannot do, so this is a Developer ID build and
  # never an App Store one.
  depends_on macos: :monterey

  app "Snapped.app"

  zap trash: [
    "~/Library/Application Support/com.tompod.snapped",
    "~/Library/Caches/com.tompod.snapped",
    "~/Library/HTTPStorages/com.tompod.snapped",
    "~/Library/Preferences/com.tompod.snapped.plist",
    "~/Library/Saved Application State/com.tompod.snapped.savedState",
  ]

  caveats do
    <<~EOS
      Snapped needs Accessibility permission to move other applications'
      windows. Grant it in System Settings -> Privacy & Security ->
      Accessibility; the app watches for the switch and lets you in about a
      second after it goes on.
    EOS
  end
end
