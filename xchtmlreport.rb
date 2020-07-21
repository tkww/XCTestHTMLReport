class Xchtmlreport < Formula
  desc "Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.2.3.tar.gz"
  sha256 "990049e044f393a670a693ba54bac7ccfa6c730bb1764a9e231b35356a155151"

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
