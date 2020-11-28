<!-- TOC -->

- [HighDPI](#highdpi)
- [pip](#pip)
- [brew & gnu tools](#brew--gnu-tools)
- [Hackintosh](#hackintosh)
    - [Build an OS X boot disk](#build-an-os-x-boot-disk)
    - [On QEMU/KVM](#on-qemukvm)

<!-- /TOC -->

# HighDPI
```
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
```

# pip
```
wget https://bootstrap.pypa.io/3.2/get-pip.py
sudo python get-pip.py
```

# brew & gnu tools
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
brew install findutils --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gnu-tar --with-default-names
brew install gawk
```

# Hackintosh
## Build an OS X boot disk
http://diskmakerx.com/

## On QEMU/KVM
https://github.com/kholia/OSX-KVM