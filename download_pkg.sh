#!/usr/bin/env bash

#!/usr/bin/env bash

case `uname` in
    Linux)
        pkgs_conda="pkgs_conda_linux.txt"
        ;;
    Darwin)
        pkgs_conda="pkgs_conda_macos.txt"
        ;;
    *)
        echo "Error! Unsupported OS."
        return
        ;;
esac

echo "Clean conda cache..."
conda clean -a -q -y

echo "Change conda config..."
conda config --remove pkgs_dirs ~/anaconda3/pkgs
conda config --prepend pkgs_dirs ./pkgs
echo $(conda config --show pkgs_dirs)

echo "Downloading Anaconda Packages..."
cat $pkgs_conda | paste -sd " " - | xargs conda install --name vopt --force --yes --channel anaconda --download-only

echo "Downloading Conda-Forge Packages..."
cat pkgs_conda-forge.txt | paste -sd " " - | xargs conda install --name vopt --force --yes --channel conda-forge --download-only

echo "Splitting large file..."
find ./pkgs -type f -size +100M | while read file; do
    split -b 50000k ${file} ${file}.
    rm ${file}
done

echo "Clean conda cache..."
rm -Rf `ls -1 -d ./pkgs/*/`

echo "Recover conda config..."
conda config --remove pkgs_dirs ./pkgs
conda config --prepend pkgs_dirs ~/anaconda3/pkgs
echo $(conda config --show pkgs_dirs)

echo "Downloading pip Packages..."
rm -Rf `ls -1 ./pkgs_pip/*`
cat pkgs_pip.txt | paste -sd " " - | xargs pip download --no-deps -d pkgs_pip

echo "Downloading CyLP@py3 Packag3..."
wget https://github.com/VeranosTech/CyLP/archive/py3.zip -O pkgs_pip/cylp.zip
