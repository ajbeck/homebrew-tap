class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.4.0/scut-v0.4.0-darwin-arm64.tar.gz"
      sha256 "a10fdbf84aec89159d4440c258f5558d540d8c939e58f10e4eb3850115d079c8"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.4.0/scut-v0.4.0-darwin-amd64.tar.gz"
      sha256 "d24324c245cbc7eda0b04626092b0295f60617f993456077e941da86b5569755"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.4.0/scut-v0.4.0-linux-arm64.tar.gz"
      sha256 "51db5d4068e9e6de6d79785b99a439c44e67d4f45547f95882096d05c05ff7af"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.4.0/scut-v0.4.0-linux-amd64.tar.gz"
      sha256 "6cec46ce734f829d750a19ae5636ae127d12b45156af703b4a8f2ec2417c3000"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
