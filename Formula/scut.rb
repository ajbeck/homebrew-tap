class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.0/scut-v0.3.0-darwin-arm64.tar.gz"
      sha256 "45b083fb3b2702dce4a773781e6f28509ffe8ca886e95397e537ab6a172f407c"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.0/scut-v0.3.0-darwin-amd64.tar.gz"
      sha256 "cabbf7aa3167fec74f709846d94a047d0b06258c07f9ad8edd15914185b382a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.0/scut-v0.3.0-linux-arm64.tar.gz"
      sha256 "44b0fc339c8495685e96c4f8e00d2cbedc201966e4a47c80ef9e5adccd2ca9d2"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.0/scut-v0.3.0-linux-amd64.tar.gz"
      sha256 "db0fc94c7cfbbcffae9eac8ba1340cb314abbc325864301b41de1954ee3d6807"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
