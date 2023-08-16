mkdocs --version
echo tip: pip install --upgrade mkdocs
echo

echo pwd: $(pwd)
echo

get_get_path_site_packages(){
    python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])'
}

path_site_packages=$(get_get_path_site_packages)
path_files_py=$path_site_packages/mkdocs/structure/files.py

echo "Pre Hack $path_files_py :"
grep followlinks $path_files_py

grep "followlinks=True" $path_files_py &>/dev/null && {

    sed -i "s/followlinks=True/followlinks=False/g" $path_files_py

    echo "Post Hack $path_files_py :"
    grep followlinks $path_files_py

}