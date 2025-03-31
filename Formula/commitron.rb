class Commitron < Formula
  desc "AI-driven CLI tool that generates optimal, context-aware commit messages"
  homepage "https://github.com/stiliajohny/commitron"
  url "https://github.com/stiliajohny/commitron/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  # Replace this line with the SHA256 you got from step 6
  sha256 "PASTE_THE_ACTUAL_SHA256_HERE"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"commitron", "./cmd/commitron"
  end

  test do
    system "#{bin}/commitron", "--version"
  end
end