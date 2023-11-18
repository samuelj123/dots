#!/usr/bin/env sh

if [ -z "$XDG_PICTURES_DIR" ] ; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')

mkdir -p $save_dir

function print_error
{
cat << "EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
EOF
}

case $1 in
p)  # print all outputs
    grim "$save_file" && feh "$save_file" ;;
s)  # drag to manually snip an area / click on a window to print it
    grim -g "$(slurp)" "$save_file" && feh "$save_file" ;;
*)  # invalid option
    print_error ;;
esac


