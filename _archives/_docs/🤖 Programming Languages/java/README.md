# Java

Plugin: [asdf-java](https://github.com/halcyon/asdf-java)

```shell
asdf plugin add java
asdf list all java | grep temurin    # pick a distribution, for example Eclipse Temurin
asdf install java <version>          # a name from the list, for example temurin-21.x.y+z
asdf set -u java <version>

java --version
```

To set `JAVA_HOME` from the selected version, add this line to `~/.zshrc`:

```shell
. ~/.asdf/plugins/java/set-java-home.zsh
```

For bash, source `set-java-home.bash` from the same directory instead.
