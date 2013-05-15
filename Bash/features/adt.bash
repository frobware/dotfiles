# Android developer tools.

if [ -x $HOME/adt-bundle-linux-x86_64-20130219/sdk/platform-tools/adb ];
then
    path_prepend PATH $HOME/adt-bundle-linux-x86_64-20130219/sdk/platform-tools
fi

provide adt
