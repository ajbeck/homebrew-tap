class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.3/scut-v0.3.3-darwin-arm64.tar.gz"
      sha256 "3b37cdf60d31c36100a95c187dd55c42bc36771b0a70b9c7e2230ec5fa18624a"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.3/scut-v0.3.3-darwin-amd64.tar.gz"
      sha256 "5c2b1dcdb511ff15a2e855448f9ce9a72e92e0a9aafbcd45d666b95678e40ada"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.3/scut-v0.3.3-linux-arm64.tar.gz"
      sha256 "e0d9b9aded949ce12b097b6b5d4ddd3a63bc19d4a4726bdcb3e289128d593f39"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.3/scut-v0.3.3-linux-amd64.tar.gz"
      sha256 "35861fc659a78a89736e32fa30c1292f5d4fc85dd087374321ad0d2cec3b3d9f"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
