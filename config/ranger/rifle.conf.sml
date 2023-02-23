# vim: ft=cfg
#
# This is the configuration file of "rifle", ranger's file executor/opener.
# Each line consists of conditions and a command.  For each line the conditions
# are checked and if they are met, the respective command is run.
#
# Syntax:
#   <condition1> , <condition2> , ... = command
#
# The command can contain these environment variables:
#   $1-$9 | The n-th selected file
#   $@    | All selected files
#
# If you use the special command "ask", rifle will ask you what program to run.
#
# Prefixing a condition with "!" will negate its result.
# These conditions are currently supported:
#   match <regexp> | The regexp matches $1
#   ext <regexp>   | The regexp matches the extension of $1
#   mime <regexp>  | The regexp matches the mime type of $1
#   name <regexp>  | The regexp matches the basename of $1
#   path <regexp>  | The regexp matches the absolute path of $1
#   has <program>  | The program is installed (i.e. located in $PATH)
#   env <variable> | The environment variable "variable" is non-empty
#   file           | $1 is a file
#   directory      | $1 is a directory
#   number <n>     | change the number of this command to n
#   terminal       | stdin, stderr and stdout are connected to a terminal
#   X              | $DISPLAY is not empty (i.e. Xorg runs)
#
# There are also pseudo-conditions which have a "side effect":
#   flag <flags>  | Change how the program is run. See below.
#   label <label> | Assign a label or name to the command so it can
#                 | be started with :open_with <label> in ranger
#                 | or `rifle -p <label>` in the standalone executable.
#   else          | Always true.
#
# Flags are single characters which slightly transform the command:
#   f | Fork the program, make it run in the background.
#     |   New command = setsid $command >& /dev/null &
#   r | Execute the command with root permissions
#     |   New command = sudo $command
#   t | Run the program in a new terminal.  If $TERMCMD is not defined,
#     | rifle will attempt to extract it from $TERM.
#     |   New command = $TERMCMD -e $command
# Note: The "New command" serves only as an illustration, the exact
# implementation may differ.
# Note: When using rifle in ranger, there is an additional flag "c" for
# only running the current file even if you have marked multiple files.

#-------------------------------------------
# Websites
#-------------------------------------------
# Rarely installed browsers get higher priority; It is assumed that if you
# install a rare browser, you probably use it.  Firefox/konqueror/w3m on the
# other hand are often only installed as fallback browsers.
ext x?html?, has surf,             X, flag f = surf -- file://"$1"
ext x?html?, has vimprobable,      X, flag f = vimprobable -- "$@"
ext x?html?, has vimprobable2,     X, flag f = vimprobable2 -- "$@"
ext x?html?, has qutebrowser,      X, flag f = qutebrowser -- "$@"
ext x?html?, has dwb,              X, flag f = dwb -- "$@"
ext x?html?, has jumanji,          X, flag f = jumanji -- "$@"
ext x?html?, has luakit,           X, flag f = luakit -- "$@"
ext x?html?, has uzbl,             X, flag f = uzbl -- "$@"
ext x?html?, has uzbl-tabbed,      X, flag f = uzbl-tabbed -- "$@"
ext x?html?, has uzbl-browser,     X, flag f = uzbl-browser -- "$@"
ext x?html?, has uzbl-core,        X, flag f = uzbl-core -- "$@"
ext x?html?, has midori,           X, flag f = midori -- "$@"
ext x?html?, has chromium-browser, X, flag f = chromium-browser -- "$@"
ext x?html?, has chromium,         X, flag f = chromium -- "$@"
ext x?html?, has google-chrome,    X, flag f = google-chrome -- "$@"
ext x?html?, has opera,            X, flag f = opera -- "$@"
ext x?html?, has firefox,          X, flag f = firefox -- "$@"
ext x?html?, has seamonkey,        X, flag f = seamonkey -- "$@"
ext x?html?, has iceweasel,        X, flag f = iceweasel -- "$@"
ext x?html?, has epiphany,         X, flag f = epiphany -- "$@"
ext x?html?, has konqueror,        X, flag f = konqueror -- "$@"
ext x?html?, has elinks,            terminal = elinks "$@"
ext x?html?, has links2,            terminal = links2 "$@"
ext x?html?, has links,             terminal = links "$@"
ext x?html?, has lynx,              terminal = lynx -- "$@"
ext x?html?, has w3m,               terminal = w3m "$@"

#-------------------------------------------
# Misc
#-------------------------------------------
# Define the "editor" for text files as first action
mime ^text,  label editor = ${VISUAL:-$EDITOR} -- "$@"
mime ^text,  label pager  = "$PAGER" -- "$@"
!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php|md|sml|txt|vim = ${VISUAL:-$EDITOR} -- "$@"
!mime ^text, label pager,  ext xml|json|csv|tex|py|pl|rb|js|sh|php|md|sml|txt|vim = "$PAGER" -- "$@"

ext 1                         = man "$1"
ext s[wmf]c, has zsnes, X     = zsnes "$1"
ext s[wmf]c, has snes9x-gtk,X = snes9x-gtk "$1"
ext nes, has fceux, X         = fceux "$1"
ext exe                       = wine "$1"
name ^[mM]akefile$            = make

#--------------------------------------------
# Code
#-------------------------------------------
ext py  = python -- "$1"
ext pl  = perl -- "$1"
ext rb  = ruby -- "$1"
ext js  = node -- "$1"
ext sh  = sh -- "$1"
ext php = php -- "$1"

#--------------------------------------------
# Audio without X
#-------------------------------------------
mime ^audio|ogg$, terminal, has mpv      = mpv -- "$@"
mime ^audio|ogg$, terminal, has mplayer2 = mplayer2 -- "$@"
mime ^audio|ogg$, terminal, has mplayer  = mplayer -- "$@"
mime ^audio|ogg$, terminal, has play     = play -- "$@"
ext midi?,        terminal, has wildmidi = wildmidi -- "$@"

#--------------------------------------------
# Video/Audio with a GUI
#-------------------------------------------
mime ^video|audio, has gmplayer, X, flag f = gmplayer -- "$@"
mime ^video|audio, has smplayer, X, flag f = smplayer "$@"
mime ^video,       has mpv,      X, flag f = mpv -- "$@"
mime ^video,       has mpv,      X, flag f = mpv --fs -- "$@"
mime ^video,       has mplayer2, X, flag f = mplayer2 -- "$@"
mime ^video,       has mplayer2, X, flag f = mplayer2 -fs -- "$@"
mime ^video,       has mplayer,  X, flag f = mplayer -- "$@"
mime ^video,       has mplayer,  X, flag f = mplayer -fs -- "$@"
mime ^video|audio, has vlc,      X, flag f = vlc -- "$@"
mime ^video|audio, has totem,    X, flag f = totem -- "$@"
mime ^video|audio, has totem,    X, flag f = totem --fullscreen -- "$@"

#--------------------------------------------
# Video without X:
#-------------------------------------------
mime ^video, terminal, !X, has mpv       = mpv -- "$@"
mime ^video, terminal, !X, has mplayer2  = mplayer2 -- "$@"
mime ^video, terminal, !X, has mplayer   = mplayer -- "$@"

#-------------------------------------------
# Documents
#-------------------------------------------
ext pdf, has llpp,     X, flag f = llpp "$@"
ext pdf, has zathura,  X, flag f = zathura -- "$@"
ext pdf, has mupdf,    X, flag f = mupdf "$@"
ext pdf, has mupdf-x11,X, flag f = mupdf-x11 "$@"
ext pdf, has apvlv,    X, flag f = apvlv -- "$@"
ext pdf, has xpdf,     X, flag f = xpdf -- "$@"
ext pdf, has evince,   X, flag f = evince -- "$@"
ext pdf, has atril,    X, flag f = atril -- "$@"
ext pdf, has okular,   X, flag f = okular -- "$@"
ext pdf, has epdfview, X, flag f = epdfview -- "$@"
ext pdf, has qpdfview, X, flag f = qpdfview "$@"
ext pdf, has open,     X, flag f = open "$@"

ext docx?, has catdoc,       terminal = catdoc -- "$@" | "$PAGER"

# ext                            sxc|xlsx?|xlt|xlw|gnm|gnumeric, has gnumeric,    X, flag f = gnumeric -- "$@"
ext                            sxc|xlsx?|xlt|xlw|gnm|gnumeric, has kspread,     X, flag f = kspread -- "$@"
ext p[op]tx?|od[dfgpst]|docx?|rtf|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f = libreoffice "$@"
ext p[op]tx?|od[dfgpst]|docx?|rtf|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has soffice,     X, flag f = soffice "$@"
ext p[op]tx?|od[dfgpst]|docx?|rtf|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has ooffice,     X, flag f = ooffice "$@"

ext djvu, has zathura,X, flag f = zathura -- "$@"
ext djvu, has evince, X, flag f = evince -- "$@"
ext djvu, has atril,  X, flag f = atril -- "$@"

ext ps, has zathura,  X, flag f = zathura -- "$@"
ext ps, has qpdfview, X, flag f = qpdfview "$@"

ext epub, has ebook-viewer, X, flag f = ebook-viewer -- "$@"
ext mobi, has ebook-viewer, X, flag f = ebook-viewer -- "$@"

#-------------------------------------------
# Image Viewing:
#-------------------------------------------
mime ^image/svg, has inkscape, X, flag f = inkscape -- "$@"
mime ^image/svg, has display,  X, flag f = display -- "$@"

mime ^image, has pqiv,      X, flag f = pqiv -- "$@"
mime ^image, has sxiv,      X, flag f = sxiv -- "$@"
mime ^image, has feh,       X, flag f = feh -- "$@"
mime ^image, has mirage,    X, flag f = mirage -- "$@"
mime ^image, has ristretto, X, flag f = ristretto "$@"
mime ^image, has eog,       X, flag f = eog -- "$@"
mime ^image, has eom,       X, flag f = eom -- "$@"
mime ^image, has nomacs,    X, flag f = nomacs -- "$@"
mime ^image, has geeqie,    X, flag f = geeqie -- "$@"
mime ^image, has gwenview,  X, flag f = gwenview -- "$@"
mime ^image, has gpicview,  X, flag f = gpicview -- "$@"
mime ^image, has gimp,      X, flag f = gimp -- "$@"
ext xcf, has gimp,          X, flag f = gimp -- "$@"

#-------------------------------------------
# Archives
#-------------------------------------------

# avoid password prompt by providing empty password
ext 7z, has 7z = 7z -p l "$@" | "$PAGER"
# This requires atool
ext ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz,     has atool = atool --list --each -- "$@" | "$PAGER"
ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool = atool --list --each -- "$@" | "$PAGER"
ext 7z|ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz,  has atool = atool --extract --each -- "$@"
ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool = atool --extract --each -- "$@"

# Listing and extracting archives without atool:
ext tar|gz|bz2|xz, has tar = tar vvtf "$1" | "$PAGER"
ext tar|gz|bz2|xz, has tar = for file in "$@"; do tar vvxf "$file"; done
ext bz2, has bzip2 = for file in "$@"; do bzip2 -dk "$file"; done
ext zip, has unzip = unzip -l "$1" | less
ext zip, has unzip = for file in "$@"; do unzip -d "${file%.*}" "$file"; done
ext ace, has unace = unace l "$1" | less
ext ace, has unace = for file in "$@"; do unace e "$file"; done
ext rar, has unrar = unrar l "$1" | less
ext rar, has unrar = for file in "$@"; do unrar x "$file"; done

#-------------------------------------------
# Misc
#-------------------------------------------
label wallpaper, number 11, mime ^image, has feh, X = feh --bg-scale "$1"
label wallpaper, number 12, mime ^image, has feh, X = feh --bg-tile "$1"
label wallpaper, number 13, mime ^image, has feh, X = feh --bg-center "$1"
label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"

# Define the editor for non-text files + pager as last action
              !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = ask
label editor, !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = ${VISUAL:-$EDITOR} -- "$@"
label pager,  !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = "$PAGER" -- "$@"

# The very last action, so that it's never triggered accidentally, is to execute a program:
mime application/x-executable = "$1"
