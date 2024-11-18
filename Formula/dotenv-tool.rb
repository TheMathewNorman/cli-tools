class DotenvTool < Formula
  desc "A tool for viewing and modifying .env files from the command-line"
  homepage "https://github.com/TheMathewNorman/dotenv-tool"
  url "https://github.com/TheMathewNorman/dotenv-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e756d147ee09976098a799bc2ffa492e4e77879e4d879f6731b8e9d1bff4a0cb"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    checks = shell_output(bin/"dotenv-tool").split("\n")
    assert_includes checks, "\tdotenv-tool <COMMAND> [OPTIONS] [ARGS]"

    (testpath/".env").write <<~EOS
      FOO=bar
      BAR=foo
    EOS

    output = shell_output(bin/"dotenv-tool show FOO")
    assert_includes(output, "bar")

    shell_output(bin/"dotenv-tool set FOO foo")
    output = shell_output(bin/"dotenv-tool show FOO")
    assert_includes(output, "foo")
  end
end
