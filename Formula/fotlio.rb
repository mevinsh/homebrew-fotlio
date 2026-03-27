class Fotlio < Formula
  desc "Your photo library, beautifully organised"
  homepage "https://github.com/mevinsh/photo-organiser"
  url "https://github.com/mevinsh/photo-organiser/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "80f18b25f76e5a2b0a18102bf3f2504f20f68747bb2ba0fcd6c45cae299f72c6"
  license "MIT"

  head "https://github.com/mevinsh/photo-organiser.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "uv"

  def install
    # Create an isolated Python virtual environment in Homebrew's libexec
    system "uv", "venv", libexec

    # Install fotlio + all its Python dependencies into that venv
    system "uv", "pip", "install",
           "--python", libexec/"bin/python",
           "--no-cache",
           buildpath

    # Expose the fotlio binary via Homebrew's bin directory
    bin.install_symlink libexec/"bin/fotlio"
    bin.install_symlink libexec/"bin/photo-organiser"
  end

  test do
    assert_match "1.0.0", shell_output("#{bin}/fotlio --version")
  end
end
