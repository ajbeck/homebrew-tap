class Scut < Formula
  desc "CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting"
  homepage "https://github.com/ajbeck/scut"
  version "0.3.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.4/scut-v0.3.4-darwin-arm64.tar.gz"
      sha256 "00e1b8044722d4cdc590ef5c65f93e4f6955cfbc275a57f6ed0e4723fdd25830"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.4/scut-v0.3.4-darwin-amd64.tar.gz"
      sha256 "695b212fb7de7d76b15cf211cf6da081acfd0d0b5e4e50b1989f31365bbd1586"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.4/scut-v0.3.4-linux-arm64.tar.gz"
      sha256 "52b4d81f0402578b79f54fe361cdab402c290052bfaca26e651d6b25c41d91a2"
    end
    on_intel do
      url "https://github.com/ajbeck/scut/releases/download/v0.3.4/scut-v0.3.4-linux-amd64.tar.gz"
      sha256 "40257c537adfa194ad822b91cf29645572d39c40c0a288d563ffafa9f8c86c42"
    end
  end

  def install
    bin.install "scut"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scut version")
  end
end
