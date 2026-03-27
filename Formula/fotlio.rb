class Fotlio < Formula
  desc "Your photo library, beautifully organised"
  homepage "https://github.com/mevinsh/photo-organiser"
  url "https://github.com/mevinsh/photo-organiser/archive/fd960bb7f59740e032713011994104929920de5b.tar.gz"
  version "1.0.0"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
