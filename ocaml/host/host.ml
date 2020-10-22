let load_extension path =
  try Dynlink.loadfile_private path with
  | Dynlink.Error err -> Printf.printf "%s\n" @@ Dynlink.error_message err
  | _ -> failwith "Unknown error calling Dynlink.loadfile"

let register_callbacks () =
  Callback.register "load_extension" load_extension

let init_extension_host () =
  (* Ensure the Api implementation is loaded. *)
  Dynlink.loadfile "_build/default/ocaml/api/api.cma";
  (* Initialize the Random module with a system-dependent seed. *)
  Random.self_init ()

let () =
  print_endline "registering callbacks";
  register_callbacks ();
  init_extension_host ()

(* hack needed to force linking of object system into runtime *)
let _ = object end
