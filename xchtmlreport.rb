class Xchtmlreport < Formula
  desc "XCTestHTMLReport: Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.2.2.zip"
  sha256 "96e7c2ecb0aad3c340934ba8140ccbe46e21cd7ab7f861f78a4160e33aff7550"
  head "https://github.com/tkww/XCTestHTMLReport.git", :branch => "master"

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
