require "language/node"

class Commitlint < Formula
  desc "Lint commit messages according to a commit convention"
  homepage "https://commitlint.js.org/#/"
  url "https://registry.npmjs.org/commitlint/-/commitlint-18.6.0.tgz"
  sha256 "0b0b780739539423de54a0d1ac46a3f7e079a01314812fda8705b0a927018ee3"
  license "MIT"
  head "https://github.com/conventional-changelog/commitlint.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b3508fc9169b655d62eac534a37727a0bcebdceddd67a56c46b1657feb506956"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b3508fc9169b655d62eac534a37727a0bcebdceddd67a56c46b1657feb506956"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3508fc9169b655d62eac534a37727a0bcebdceddd67a56c46b1657feb506956"
    sha256 cellar: :any_skip_relocation, sonoma:         "0fdfd7b03a6a1a348b4bf7c40060295a94b401ce75cc320fef59faf987267289"
    sha256 cellar: :any_skip_relocation, ventura:        "0fdfd7b03a6a1a348b4bf7c40060295a94b401ce75cc320fef59faf987267289"
    sha256 cellar: :any_skip_relocation, monterey:       "0fdfd7b03a6a1a348b4bf7c40060295a94b401ce75cc320fef59faf987267289"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b3508fc9169b655d62eac534a37727a0bcebdceddd67a56c46b1657feb506956"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"commitlint.config.js").write <<~EOS
      module.exports = {
          rules: {
            'type-enum': [2, 'always', ['foo']],
          },
        };
    EOS
    assert_match version.to_s, shell_output("#{bin}/commitlint --version")
    assert_equal "", pipe_output("#{bin}/commitlint", "foo: message")
  end
end
