use glob::glob;
use std::process::Command;

fn main() -> anyhow::Result<()> {
    let dir_out = std::env::var("OUT_DIR")?;
    let dir_ocaml = "../../ocaml";
    let dir_dune = "../../_build/default";

    // Install OCaml dependencies.
    let mut cmd = Command::new("opam");
    cmd.args(&["pin", "add", "-y", "rust-ocaml-dyn", "."]);
    cmd.current_dir(dir_ocaml);
    cmd.status()?;

    // Build the OCaml extension host and extensions with Dune.
    let mut cmd = Command::new("opam");
    cmd.args(&["exec", "--", "dune", "build"]);
    cmd.current_dir(dir_ocaml);
    cmd.status()?;

    // Remove the old archive file.
    let mut cmd = Command::new("rm");
    cmd.args(&["-f", &format!("{}/libhost.a", dir_out)]);
    cmd.status()?;

    // Create the archive file from the object file.
    let mut cmd = Command::new("ar");
    cmd.args(&[
        "qs",
        &format!("{}/libhost.a", dir_out),
        &format!("{}/ocaml/host/host.bc.o", dir_dune),
    ]);
    cmd.status()?;

    // Re-run if `dune-project` changes.
    println!("cargo:rerun-if-changed={}/dune-project", dir_ocaml);

    // Re-run if `**/dune` files change.
    for path in glob(&format!("{}/**/dune", dir_ocaml))? {
        if let Some(path) = path?.to_str() {
            println!("cargo:rerun-if-changed={}", path);
        }
    }

    // Re-run if `**/*.mli?` files change.
    for path in glob(&format!("{}/**/*.ml", dir_ocaml))? {
        if let Some(path) = path?.to_str() {
            println!("cargo:rerun-if-changed={}", path);
        }
    }

    // Re-run if `**/*.mli?` files change.
    for path in glob(&format!("{}/**/*.mli", dir_ocaml))? {
        if let Some(path) = path?.to_str() {
            println!("cargo:rerun-if-changed={}", path);
        }
    }

    // Configure linking for the extension host object file.
    println!("cargo:rustc-link-search={}", dir_out);
    println!("cargo:rustc-link-lib=static=host");

    Ok(())
}
