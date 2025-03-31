class Commitron < Formula
  desc "AI-driven CLI tool that generates optimal, context-aware commit messages"
  homepage "https://github.com/stiliajohny/commitron"
  url "https://github.com/stiliajohny/commitron/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  # After creating the release, replace this with the actual SHA256 from:
  # curl -L "https://github.com/stiliajohny/commitron/archive/refs/tags/v0.1.0.tar.gz" | shasum -a 256
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"commitron", "./cmd/commitron"
  end

  test do
    system "#{bin}/commitron", "--version"
  end
end