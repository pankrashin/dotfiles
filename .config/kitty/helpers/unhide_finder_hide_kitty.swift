import AppKit

let finder = "com.apple.finder"
let kitty = "net.kovidgoyal.kitty"
let app = { NSRunningApplication.runningApplications(withBundleIdentifier: $0).first }
app(finder)?.unhide()
while app(finder)?.isHidden == true {}
app(kitty)?.hide()
