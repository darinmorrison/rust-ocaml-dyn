use glob::glob;
use ocaml_interop::{ocaml_call, ocaml_frame, to_ocaml, OCamlError, OCamlException, OCamlRuntime, ToOCaml};
use thiserror::Error;

fn extract_exception(error: &OCamlError) -> &OCamlException {
    let OCamlError::Exception(exception) = error;
    exception
}

#[derive(Error, Debug)]
pub enum Error {
    #[error("OCaml error: {:?}", extract_exception(.0).message())]
    OCamlError(OCamlError),
}

mod ocaml {
    use ocaml_interop::ocaml;

    ocaml! {
        pub fn load_extension(ext_name: String);
    }
}

fn main() -> anyhow::Result<()> {
    let paths = glob("_build/default/ocaml/**/*.cma")?;
    OCamlRuntime::init_persistent();
    ocaml_frame!(gc, {
        for result in paths {
            let path = result?;
            println!("loading: {:#?}", path);
            if path.ends_with("api.cma") {
                continue;
            }
            if let Some(path) = path.to_str() {
                ocaml_call!(ocaml::load_extension(gc, to_ocaml!(gc, path))).map_err(Error::OCamlError)?;
            }
        }
    });
    OCamlRuntime::shutdown_persistent();
    Ok(())
}
