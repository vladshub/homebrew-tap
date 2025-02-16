class VaultEnterprise < Formula
  desc "Vault Enterprise"
  homepage "https://www.vaultproject.io"
  version "1.11.3+ent"

  if OS.mac? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/vault/1.11.3+ent/vault_1.11.3+ent_darwin_amd64.zip"
    sha256 "2c577de00b72c847592aee9e5ed25d716dc3427383a0cb97550e8f2fb786ca8b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.hashicorp.com/vault/1.11.3+ent/vault_1.11.3+ent_darwin_arm64.zip"
    sha256 "82b0782b95a2c847e84ce9628d2e3b6d61e9dfb3f66fc5e3dec3838dd1e57d2e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/vault/1.11.3+ent/vault_1.11.3+ent_linux_amd64.zip"
    sha256 "1fba33d24170081696a8684bc55291ece3eae48943c20aa4de2c999515691ccf"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/vault/1.11.3+ent/vault_1.11.3+ent_linux_arm.zip"
    sha256 "f45d2164d4941d069e916e35d339748a7cc4ec84f63688fe5203bf7c1e33747f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/vault/1.11.3+ent/vault_1.11.3+ent_linux_arm64.zip"
    sha256 "e6dade7c8af7b09cc164d2f3195ee464dcb85d63a22d3bc13c92d3cc1e1de632"
  end

  conflicts_with "vault-enterprise"

  def install
    bin.install "vault"
  end

  plist_options manual: "vault server -dev"

  def plist; <<~EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
        <string>#{opt_bin}/vault</string>
        <string>server</string>
        <string>-dev</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>#{var}</string>
    <key>StandardErrorPath</key>
    <string>#{var}/log/vault.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/vault.log</string>
</dict>
</plist>

EOS
  end

  test do
    system "#{bin}/vault --version"
  end
end
