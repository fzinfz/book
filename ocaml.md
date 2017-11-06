<!-- TOC -->

- [Init](#init)
- [opam](#opam)
- [Jupyter](#jupyter)
- [Course](#course)

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

# opam
    opam list -a         # List all available packages
    opam update          # Update the packages database
    opam upgrade         # Bring everything to the latest version possible    

    opam switch list --all
    opam switch <version> && eval $(opam config env)

    opam pin add camlpdf ~/src/camlpdf                            # path
    opam pin list

    opam install depext
    opam depext <packages>
    opam list --rec --required-by <package>,<package>... --external

    opam switch export file.export  # from the previous switch
    opam switch <new switch>
    opam switch import file.export

# Jupyter
https://github.com/akabe/docker-ocaml-jupyter-datascience

# Course
http://www.cs.cornell.edu/courses/cs3110/