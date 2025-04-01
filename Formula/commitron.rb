class Commitron < Formula
  desc "AI-driven CLI tool that generates optimal, context-aware commit messages"
  homepage "https://github.com/stiliajohny/commitron"
  url "https://github.com/stiliajohny/commitron/archive/refs/tags/v0.1.0.tar.gz"
  # Copy the SHA256 output from step 4 here
  sha256 "9d9aef9610f06d39d8e4ce76b808a06bb84a34daf78a2e82841c4b57bbc4b1ff"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"commitron", "./cmd/commitron"
  end

  test do
    system "#{bin}/commitron", "--version"
  end
end
