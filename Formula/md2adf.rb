class Md2adf < Formula
  desc "CLI tool to convert Markdown to Atlassian Document Format (ADF)"
  homepage "https://github.com/ajbeck/md2adf"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.1.0/md2adf-darwin-arm64.gz"
      sha256 "0ccff65d4b5abddc2e22f2b1636a751395fb61e124f8d0fbed0761c4ee1be6cd"
    end
    on_intel do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.1.0/md2adf-darwin-amd64.gz"
      sha256 "49987269cb954b66763453349b5df7ed325e8c8bff807de1cbb9792f2633a6cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.1.0/md2adf-linux-arm64.gz"
      sha256 "26e683a9fc1cceab336162197413b2d3684d93fb47d2b3c8a7a71fd7d32fdec6"
    end
    on_intel do
      url "https://github.com/ajbeck/md2adf/releases/download/v1.1.0/md2adf-linux-amd64.gz"
      sha256 "ba9756864eb0d6e9267ff55240ef296a377cacbe6ba5339e19592069842eca96"
    end
  end

  def install
    # Homebrew auto-extracts the .gz; install the extracted binary
    # Each platform downloads only its specific URL, so we just rename the result
    bin.install Dir["md2adf-*"].first => "md2adf"
  end

  test do
    # Verify the binary runs and converts markdown to ADF
    output = shell_output("#{bin}/md2adf -s '# Hello'")
    assert_match "heading", output
  end
end
