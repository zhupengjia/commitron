class Commitron < Formula
  desc "AI-driven CLI tool that generates optimal, context-aware commit messages"
  homepage "https://github.com/stiliajohny/commitron"
  url "https://github.com/stiliajohny/commitron/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "YOUR_SHA256_HERE" # This will need to be updated when you create a release

  depends_on "go" => :build

  def install
    # Set GOPATH to the buildpath
    ENV["GOPATH"] = buildpath

    # Clone the repository
    system "git", "clone", "https://github.com/stiliajohny/commitron.git", "src/github.com/stiliajohny/commitron"

    # Build the binary
    system "go", "build", "-o", bin/"commitron", "./cmd/commitron"
  end

  test do
    system "#{bin}/commitron", "--version"
  end
end