class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.2/scut-v0.3.2-darwin-arm64.tar.gz"
      sha256 "e156e9d49694f5ced2701a0d24e6d4b6082c008e5cef9b14106ce98f6349aba3"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.2/scut-v0.3.2-darwin-amd64.tar.gz"
      sha256 "b3d7224d52ab1d1d2c42736d5c1aab3f15fc6cba30210243eb5f28b1fcd0e4da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.2/scut-v0.3.2-linux-arm64.tar.gz"
      sha256 "b55763fc732828861fb718d377134b5cb93492ad7ba533d64c57357e5cd64665"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.2/scut-v0.3.2-linux-amd64.tar.gz"
      sha256 "8106f9b105973ad8697a76b08e94a82eb29234b0dfd2590f9daa08f1ff3e9432"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
