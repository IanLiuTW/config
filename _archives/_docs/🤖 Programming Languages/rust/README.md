# Rust

The Rust project recommends [rustup](https://www.rust-lang.org/tools/install). It installs the toolchain and components such as `clippy` and `rustfmt`, and it reads a project's `rust-toolchain.toml` file.

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustc --version
cargo --version
```

To manage Rust with asdf instead, use the plugin [asdf-rust](https://github.com/asdf-community/asdf-rust):

```shell
asdf plugin add rust
asdf install rust latest
asdf set -u rust latest

rustc --version
```
