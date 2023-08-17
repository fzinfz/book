echo [Tip] pip install --upgrade mkdocs
mkdocs --version
echo

echo [SHELL] $SHELL
echo [PWD] $(pwd)
echo

path_site_packages=$( python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])' )

skip_soft_links(){

    path_files_py=$path_site_packages/mkdocs/structure/files.py

    grep "followlinks=True" $path_files_py && {

        echo '[Hack] To workaround recursively path caused by `docs -> ../` '        
        sed -i "s/followlinks=True/followlinks=False/g" $path_files_py

        echo "Post hacking $path_files_py :"
        grep followlinks $path_files_py

    }
}
skip_soft_links