class Md2adf < Formula
  desc "CLI tool to convert Markdown to Atlassian Document Format (ADF)"
  homepage "https://github.com/ajbeck/md2adf"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.0.0/md2adf-darwin-arm64.gz"
      sha256 "d1aae19a0d874d2aa24a5ab772807afd42bc9844611f55197f2a3b33b8672765"
    end
    on_intel do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.0.0/md2adf-darwin-amd64.gz"
      sha256 "5719d102db217537bc49a16f5258d70e3c13b821fb9894d4b6161faa5a122d9c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.0.0/md2adf-linux-arm64.gz"
      sha256 "9efdc8dd21617dafd6cedc08771afd464988ac28f64b2985e0bffe67dd88751f"
    end
    on_intel do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.0.0/md2adf-linux-amd64.gz"
      sha256 "e69fd49b594dfbfb740bc6e9c8c849c67f07f50e95f58d93b142baa7b6506404"
    end
  end

  def install
    # Homebrew auto-extracts the .gz; install the extracted binary
    # Each platform downloads only its specific URL, so we just rename the result
    bin.install Dir["md2adf-*"].first => "md2adf"
  end

  test do
    # Verify the binary runs and reports correct version
    output = shell_output("#{bin}/md2adf version")
    assert_match "v#{version}", output
  end
end
