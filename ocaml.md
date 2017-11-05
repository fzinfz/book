<!-- TOC -->

- [Init](#init)
- [Jupyter](#jupyter)

<!-- /TOC -->
# Init
    1. To configure OPAM in the current shell session, you need to run:

        eval `opam config env`

    2. To correctly configure OPAM for subsequent use, add the following
    line to your profile file (for instance ~/.profile):

        . /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

    3. To avoid issues related to non-system installations of `ocamlfind`
    add the following lines to ~/.ocamlinit (create it if necessary):

        let () =
            try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
            with Not_found -> ()
        ;;

# Jupyter
https://github.com/akabe/docker-ocaml-jupyter-datascience
