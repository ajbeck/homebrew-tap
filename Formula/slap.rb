class Slap < Formula
  desc "CLI tool that wraps commands and streams their output to Slack in real-time"
  homepage "https://github.com/ajbeck/slack-stdout-pipe"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.2.0/slap-darwin-arm64.tar.gz"
      sha256 "f2edbddc390ed69dcc247bd009fc6f219f37090da9328158ef630dc23f38045f"
    end
    on_intel do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.2.0/slap-darwin-amd64.tar.gz"
      sha256 "cbe3a8392f8b1a72e7a696a8882e78f39cc54fb5b0bdd68fe6f2d8ae53569b83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.2.0/slap-linux-arm64.tar.gz"
      sha256 "6ff4d182357587bdeae245681a9522f4330b63ae28c28f381a23a364a307cd5b"
    end
    on_intel do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.2.0/slap-linux-amd64.tar.gz"
      sha256 "7c7a31bf4c69977fd8c1dc83eb0ef68f4713a57559a1f9d4263793b28bbd5610"
    end
  end

  def install
    bin.install Dir["slap-*"].first => "slap"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slap --version")
  end
end
