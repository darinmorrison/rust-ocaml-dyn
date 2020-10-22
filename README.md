# rust-ocaml-dyn

An example of how to dynamically load OCaml modules with Rust

## Description

This project uses the `ocaml-interop` crate to link the OCaml runtime to a Rust
program.

The Rust program launches an extension host, built in OCaml using the `Dynlink`
module, which then loads a series of extension modules, at runtime, written in
OCaml.

The intention behind this example is to illustrate how OCaml could be used as a
scripting language for extending a game where the game engine is written in
Rust.

## Building and Running

Pre-requisites:

- [Rust](https://rustup.rs/)
- [OCaml](https://ocaml.org/docs/install.html)
- [opam](https://opam.ocaml.org/doc/Install.html)

Once you have the pre-requisites installed, simply run `cargo run`. This may
take a moment if you do not already have `dune` installed (it will be fetched
automatically by `opam`).

Running the example should produce output like the following:

```
$ cargo run
   Compiling proc-macro2 v1.0.24
   Compiling unicode-xid v0.2.1
   Compiling anyhow v1.0.33
   Compiling syn v1.0.46
   Compiling ocaml-sys v0.18.1
   Compiling glob v0.3.0
   Compiling cty v0.2.1
   Compiling host v0.1.0
   Compiling ocaml-interop v0.4.2
   Compiling quote v1.0.7
   Compiling thiserror-impl v1.0.21
   Compiling thiserror v1.0.21
    Finished dev [unoptimized + debuginfo] target(s) in 26.30s
     Running `target/debug/host`
registering callbacks
loading: "_build/default/ocaml/api/api.cma"
loading: "_build/default/ocaml/extensions/cutlass/cutlass.cma"
loading: "_build/default/ocaml/extensions/kitana/kitana.cma"
loading: "_build/default/ocaml/extensions/musket/musket.cma"
loading: "_build/default/ocaml/extensions/ninja/ninja.cma"
loading: "_build/default/ocaml/extensions/pirate/pirate.cma"
loading: "_build/default/ocaml/extensions/rum/rum.cma"
loading: "_build/default/ocaml/extensions/shuriken/shuriken.cma"
loading: "_build/default/ocaml/extensions/smoke/smoke.cma"
weapon :: registered: cutlass
weapon :: registered: kitana
weapon :: registered: musket
npc :: registered: ninja
npc :: registered: pirate
powerup :: registered: rum
weapon :: registered: shuriken
powerup :: registered: smoke
```
