class Xchtmlreport < Formula
  desc "XCTestHTMLReport: Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.1.0.zip"
  sha256 "27a917cfa70b80e1009f40902cf40314baaf30a1418e8ff299847e223885325c"
  head "https://github.com/tkww/XCTestHTMLReport.git", :branch => "master"

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
