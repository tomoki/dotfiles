#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ -f ~/.xprofile ] && source ~/.xprofile

# export XMODIFIERS='@im=uim'
# export GTK_IM_MODULE='uim'
# export QT_IM_MODULE='uim'
# uim-xim &
# uim-toolbar-gtk-systray &
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

i3config=.i3/`hostname`/config
if [ -e $i3config ]; then
    exec i3 -c "$i3config"
else
    echo "You need to add hostname to .xinitrc"
    exec i3 -c ".i3/default/config"
fi
