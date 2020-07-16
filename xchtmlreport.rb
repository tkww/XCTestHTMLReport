class Xchtmlreport < Formula
  desc "XCTestHTMLReport: Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.2.1.zip"
  sha256 "2619000d4f879ab8c771a84acc539f0c516ae48dee9f067a0525a9b843de8357"
  head "https://github.com/tkww/XCTestHTMLReport.git", :branch => "master"

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
