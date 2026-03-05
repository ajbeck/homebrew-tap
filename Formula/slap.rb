class Slap < Formula
  desc "CLI tool that wraps commands and streams their output to Slack in real-time"
  homepage "https://github.com/ajbeck/slack-stdout-pipe"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.3.0/slap-darwin-arm64.tar.gz"
      sha256 "a1d5e9512689661e03f8ced52fcc2177ff8b5e94d2414cc08fc4086f4646b871"
    end
    on_intel do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.3.0/slap-darwin-amd64.tar.gz"
      sha256 "599b95c4da8d6511402c1ef528fefa962149921c7ac36ead56a6f51f0012c178"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.3.0/slap-linux-arm64.tar.gz"
      sha256 "837ac9c0b2d9d78e57407b918c3c39826d40d8c2b476d5fbaefede68c2dcf2c0"
    end
    on_intel do
      url "https://github.com/ajbeck/slack-stdout-pipe/releases/download/v0.3.0/slap-linux-amd64.tar.gz"
      sha256 "f7e8b92f366f9510d7417281a12a6f28e22b79c4d18725eb20de9b70a8061894"
    end
  end

  def install
    bin.install Dir["slap-*"].first => "slap"
  end

  test do
    ENV["SLAP_BLOCK"] = "bingo"
    assert_match version.to_s, shell_output("#{bin}/slap")
  end
end
