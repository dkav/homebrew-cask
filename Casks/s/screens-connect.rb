cask "screens-connect" do
  version "5.2,22766"
  sha256 "8faedd8bdf9843dfce8d19c3e5796b2db5339c6b15fd8bf7576dffb586ff214e"

  url "https://updates.edovia.com/com.edovia.screens.connect.mac/ScreensConnect_#{version.csv.first}b#{version.csv.second}.zip"
  name "Screens Connect"
  desc "Remote desktop software"
  homepage "https://edovia.com/en/screens-connect/"

  livecheck do
    url "https://updates.edovia.com/com.edovia.screens.connect.mac/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Screens Connect.app"

  # Uninstall script can fail when trying to remove legacy PKGIDS
  # Original discussion: https://github.com/Homebrew/homebrew-cask/pull/8833
  uninstall launchctl: [
              "com.edovia.Screens-Connect.launcher",
              "com.edovia.screens.connect",
            ],
            quit:      "com.edovia.Screens-Connect",
            script:    {
              executable:   "#{appdir}/Screens Connect.app/Contents/Resources/sc-uninstaller.tool",
              must_succeed: false,
              sudo:         true,
            }

  zap trash: [
    "~/Library/Preferences/com.edovia.Screens-Connect.plist",
    "~/Library/Preferences/com.edovia.ScreensConnect.Shared.plist",
  ]
end
