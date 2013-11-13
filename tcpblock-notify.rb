require 'formula'

class TcpblockNotify < Formula
  homepage 'https://github.com/sakoula/tcpblock-notify'
  url 'https://github.com/sakoula/tcpblock-notify/archive/v0.1-alpha.zip'
  sha1 'd956ed97b3f16023d0f5893f0aa9eb6e33111b82'

  depends_on 'pwgen'
  # depends_on 'terminal-notifier'

  def install
    prefix.install "tcpblock-notify.sh", "com.sakoula.tcpblock-notify.plist"
#    inreplace 'com.sakoula.tcpblock-notify.plist', /TCPBLOCK_LOCATION/, "/usr/local/bin"
    system "mkdir -p ~/Library/LaunchAgents"
    system "ln -sfv #{opt_prefix}/com.sakoula.tcpblock-notify.plist ~/Library/LaunchAgents"
  end


  # def caveats; <<-EOS.undent
  #   To have launchd start tcpblock-notify at login:
  #       mkdir -p ~/Library/LaunchAgents
  #       ln -sfv #{opt_prefix}/com.sakoula.tcpblock-notify.plist ~/Library/LaunchAgents
  #   Then to load tcpblock-notify now:
  #       launchctl load ~/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
  #   EOS
  # end

end


