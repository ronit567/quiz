#!/bin/zsh
# Builds ScreenSolver.app in this folder.
set -euo pipefail
cd "$(dirname "$0")"

APP=ScreenSolver.app
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"

swiftc -O Sources/main.swift -o "$APP/Contents/MacOS/ScreenSolver"

cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleIdentifier</key><string>com.local.screensolver</string>
  <key>CFBundleName</key><string>ScreenSolver</string>
  <key>CFBundleExecutable</key><string>ScreenSolver</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSUIElement</key><true/>
</dict>
</plist>
PLIST

codesign --force --sign - --identifier com.local.screensolver "$APP"
echo "Built $PWD/$APP"
