class Xchtmlreport < Formula
  desc "XCTestHTMLReport: Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.2.0.zip"
  sha256 "1c19462a038c276416b3df8276b65c5948b1108f353bea6215a1129d3a7b4272"
  head "https://github.com/tkww/XCTestHTMLReport.git", :branch => "master"

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
