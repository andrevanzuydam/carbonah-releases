class Carbonah < Formula
  desc "The green measurement tool for developers - SCI scoring, linting, dependency analysis"
  homepage "https://carbonah.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/andrevanzuydam/carbonah-releases/releases/download/v#{version}/carbonah-darwin-arm64.tar.gz"
      # sha256 "UPDATE_AFTER_RELEASE"
    else
      url "https://github.com/andrevanzuydam/carbonah-releases/releases/download/v#{version}/carbonah-darwin-x86_64.tar.gz"
      # sha256 "UPDATE_AFTER_RELEASE"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/andrevanzuydam/carbonah-releases/releases/download/v#{version}/carbonah-linux-arm64.tar.gz"
      # sha256 "UPDATE_AFTER_RELEASE"
    else
      url "https://github.com/andrevanzuydam/carbonah-releases/releases/download/v#{version}/carbonah-linux-x86_64.tar.gz"
      # sha256 "UPDATE_AFTER_RELEASE"
    end
  end

  def install
    bin.install "carbonah"
  end

  test do
    assert_match "carbonah #{version}", shell_output("#{bin}/carbonah --version")
  end
end
