# Go

Plugin: [asdf-golang](https://github.com/asdf-community/asdf-golang)

```shell
# The plugin needs GNU coreutils and curl
brew install coreutils               # macOS
sudo apt install coreutils curl      # Debian and Ubuntu

asdf plugin add golang
asdf install golang latest
asdf set -u golang latest

go version
```

After you install a Go program with `go install`, run `asdf reshim golang` so its shim appears on `PATH`.
