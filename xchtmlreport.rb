class Xchtmlreport < Formula
  desc "Xcode-like HTML report for Unit and UI Tests"
  homepage "https://github.com/tkww/XCTestHTMLReport"
  url "https://github.com/tkww/XCTestHTMLReport/archive/2.2.3.tar.gz"
  sha256 "990049e044f393a670a693ba54bac7ccfa6c730bb1764a9e231b35356a155151"

  bottle do
    root_url "https://github.com/tkww/XCTestHTMLReport/releases/download/2.2.3/XCTestHTMLReport.zip"
    cellar :any_skip_relocation
    sha256 "3b019e877a3eefdadc2d0f53cfa8e569075f14f43f7cdbbe76c3d4be3246c2b7" => :catalina
  end

  def install
    system "swift build --disable-sandbox -c release"
    bin.install ".build/release/xchtmlreport"
  end
end
