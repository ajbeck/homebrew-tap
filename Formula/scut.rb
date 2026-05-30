class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.1.1/scut-v0.1.1-darwin-arm64.tar.gz"
      sha256 "fb8d0ea8948ccbd8e28ce55fb5d1f6885dfc4e0b340e0568cd167f2d894d9aba"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.1.1/scut-v0.1.1-darwin-amd64.tar.gz"
      sha256 "be3f10437b13ff4c258a86e10cb2b474d89410068c9c7cd568398e38989aa182"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.1.1/scut-v0.1.1-linux-arm64.tar.gz"
      sha256 "3ffc10b55d5cda2b441c90f0930110e035c61ec68650d3dbd880aed4d528808e"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.1.1/scut-v0.1.1-linux-amd64.tar.gz"
      sha256 "cfb5ab0f08ff12681a3ce8d1e8ad93156ecc940856448742557ce01a1454d975"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
