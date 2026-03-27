class Fotlio < Formula
  desc "Your photo library, beautifully organised"
  homepage "https://github.com/mevinsh/photo-organiser"
  url "https://github.com/mevinsh/photo-organiser/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "80f18b25f76e5a2b0a18102bf3f2504f20f68747bb2ba0fcd6c45cae299f72c6"
  license "MIT"

  head "https://github.com/mevinsh/photo-organiser.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "python@3.12"

  def install
    venv = libexec/"venv"

    # Create a venv using Homebrew's own python3.12 (stable, permanent path)
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", venv

    # Install fotlio + all Python dependencies into the venv
    system venv/"bin/pip", "install", "--no-cache-dir", buildpath

    # Write bash wrapper scripts so we never rely on the venv shebang path
    (bin/"fotlio").write <<~BASH
      #!/bin/bash
      exec "#{venv}/bin/fotlio" "$@"
    BASH
    chmod 0755, bin/"fotlio"

    (bin/"photo-organiser").write <<~BASH
      #!/bin/bash
      exec "#{venv}/bin/photo-organiser" "$@"
    BASH
    chmod 0755, bin/"photo-organiser"
  end

  test do
    assert_match "1.0.0", shell_output("#{bin}/fotlio --version")
  end
end
