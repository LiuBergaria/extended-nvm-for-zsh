#! /bin/zsh

if [ -d $NVM_DIR ]; then
    echo "\nCleaning old NVM installation"
    rm -rf $NVM_DIR
fi

echo "\nInstalling NVM"
(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash) &> /dev/null
nvm install --lts &> /dev/null

echo "\nInstalling extended-nvm-for-zsh"
sh ./install.sh

echo "\nReloading ~/.zshrc"
source ~/.zshrc

original_dir=$(pwd)
test_dir="/tmp/test-load-nvmrc"

test_version() {
    version=$1
    echo "\nTesting node $version"

    current_dir="$test_dir/v$version"
    mkdir -p $current_dir
    echo $version > $current_dir/.nvmrc

    cd $current_dir

    echo "Done!"
}

cleanup() {
    echo "\nRunning test cleanup"
    pkill -P $$
    cd $original_dir > /dev/null
    rm -rf $test_dir
    echo "Done!"
}

trap cleanup EXIT INT TERM

# Removes test dir if exists
[[ -d $test_dir ]] && rm -rf $test_dir

for round in {1..2}; do
    echo "\nRunning test round $round"

    for version in {12..21}; do
        test_version $version
    done
done