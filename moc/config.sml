# This is a configuration file for the MOC player.  It should be named
# 'config' and placed in the ~/.moc directory.  As this file can specify
# commands which invoke other applications, MOC will refuse to start if it
# is not owned by either root or the current user, or if it is writable by
# anyone other than its owner.  All options are given with their default
# values, and therefore commented.

# Comments begin with '#'.
# You can use quotes and escape ('\') in parameters.
#
# You can have variable values substituted by enclosing the variable name
# as "${...}".  (This only applies to the portion of the option following
# the '='.)  Variables are substituted first from the environment then,
# if not found, from the configuration options.  (Note that the value of
# a configuration option substituted is that which it has at the time the
# substitution variable is encountered.)  If there is a naming conflict
# between an environment and configuration variable, you may be able to
# resolve it by using lowercase as the environment variable matches are
# case-sensitive whereas the configuration variables are not.
#
# You can also use the form "${...:-...}" where the value in the second
# position will be substituted if the variable name given in the first
# position is unset or null.
#
# So, for example:
#
#     MusicDir = /music/${USER:-public}
#     Fastdir1 = ${MusicDir}/mp3/rock
#     Fastdir2 = ${MusicDir}/mp3/electronic
#     Fastdir3 = ${MusicDir}/mp3/rap
#     Fastdir4 = ${MusicDir}/mp3/etc
#
# Variable names are limited to those accepted by the BASH shell; that
# is, those comprising the upper- and lowercase ASCII characters, digits
# and the underscore.
#
# If you need to use the "${" sequence for any other purpose, write "$${"
# and it will be replaced by "${" and not treated as a substitution.
#
# Some options take lists of strings as their values.  The strings are
# separated by colons.  Additional strings can be appended to the list
# using "+=" in place of a plain "=" to assign the value.  For an example,
# see the XTerms option.
#
# You can override any configuration option when you run MOC using the
# '-O' command line option:
#
#     mocp -O AutoNext=no -O messagelingertime=1 -O XTerms+=xxt:xwt
#
# This command line option can be repeated as many times as needed and
# the configuration option name is not case sensitive.  (Note that MOC
# does not perform variable substitution on the value of such overridden
# configuration options.)  Most option values are set before the
# configuration file is processed (which allows the new values to be
# picked up by substitutions), however list-valued options are overridden
# afterwards (which gives the choice of whether the configured values are
# replaced or added to).

# Remember that the client and server are separate processes and the
# server will retain the configuration values formed from the environment
# within which it was originally started.

# Show file titles (title, author, album) instead of file names?
#ReadTags = yes

# In which directory do you store your music files?  If you specify it
# you will be able to jump straight to this directory with the '-m'
# parameter or the 'm' command.  This can also point to a playlist.
#
# Example:    MusicDir = "/home/joe/music"
#
MusicDir = "/home/jakub/Music"

# Start in the music directory by default?  If set to 'no', start
# in the current directory by default.  A single directory on
# the command line takes precedence.
StartInMusicDir = no

# The number of lines which are retained in an in-memory circular logging
# buffer.  A value of zero indicates that lines will be written directly
# to the log file, otherwise the latest CircularLogSize lines are retained
# in memory and not written to the log file until the MOC client or server
# are shutdown.  If the client or server terminates abnormally then the
# log lines are lost.
#
# This option is intended to help identify problems which occur infrequently
# and for which the amount of disk space consumed by logging would otherwise
# be a limiting factor.  Obviously the memory footprint will increase in
# proportion to the value of this option.
#CircularLogSize = 0

# How to sort?  FileName is the option's only value for now.
#Sort = FileName

# Show errors in the streams (for example, broken frames in MP3 files)?
#ShowStreamErrors = no

# Ignore CRC errors in MP3 files?  Most players do that, so the default
# value is 'yes'.
#MP3IgnoreCRCErrors = yes

# Set playback toggles.
#Repeat = no
#Shuffle = no
#AutoNext = yes

# Default FormatString:
#
#   %n - Track number
#   %a - Artist
#   %A - Album
#   %t - Title
#   %(X:TRUE:FALSE) - Ternary expression: if X exists, do TRUE,
#                     otherwise FALSE.  The escape character must
#                     be doubled (i.e., '\\').  (See zshmisc
#                     documentation for more information.)
#
#FormatString = "%(n:%n :)%(a:%a - :)%(t:%t:)%(A: \(%A\):)"

# Input and output buffer sizes (in kilobytes).
#InputBuffer = 512                  # Minimum value is 32KB
#OutputBuffer = 512                 # Minimum value is 128KB

# How much to fill the input buffer before playing (in kilobytes)?
# This can't be greater than the value of InputBuffer.  While this has
# a positive effect for network streams, it also causes the broadcast
# audio to be delayed.
#Prebuffering = 64

# Use this HTTP proxy server for internet streams.  If not set, the
# environment variables http_proxy and ALL_PROXY will be used if present.
#
# Format: HTTPProxy = PROXY_NAME:PORT
#
#HTTPProxy =

# Sound driver - OSS, ALSA, JACK, SNDIO (on OpenBSD) or null (only for
# debugging).  You can enter more than one driver as a colon-separated
# list.  The first working driver will be used.
#SoundDriver = JACK:ALSA:OSS

# Jack output settings.
#JackClientName = "moc"
#JackStartServer = no
#JackOutLeft = "system:playback_1"
#JackOutRight = "system:playback_2"

# OSS output settings.
#OSSDevice = /dev/dsp
#OSSMixerDevice = /dev/mixer
#OSSMixerChannel1 = pcm             # 'pcm', 'master' or 'speaker'
#OSSMixerChannel2 = master          # 'pcm', 'master' or 'speaker'

# ALSA output settings.  If you need to dump the audio produced by MOC
# to a file for diagnostic purposes, the following setting of 'ALSADevice'
# should do that:
#
#    ALSADevice=tee:hw,'/tmp/out.wav',wav
#
#ALSADevice = default
#ALSAMixer1 = PCM
#ALSAMixer2 = Master

# Under some circumstances on 32-bit systems, audio played continously
# for long periods of time may begin to stutter.  Setting this option to
# 'yes' will force MOC to avoid ALSA's dmix resampling and prevent this
# stutter.  But it also has other implications:
#
# - You may experience unacceptably high CPU load.
# - ALSA's resampler plug-ins will not be used.
# - The resampling may be of lower quality than ALSA would provide.
# - You may need to try different "ResampleMethod" option settings.
# - The "ForceSampleRate" option may be ineffective.
# - If libsamplerate is not configured, many audios may be unplayable.
#
#ALSAStutterDefeat = no

# Save software mixer state?
# If enabled, a file 'softmixer' will be created in '~/.moc/' storing the
# mixersetting set when the server is shut down.
# Note that there is a "hidden" 'Amplification' setting in that file.
# Amplification (0-200) is used to scale the mixer setting (0-100).  This
# results in a higher signal amplitude but may also produce clipping.
#Softmixer_SaveState = yes

# Save equalizer state?
# If enabled, a file 'equalizer' will be created in '~/.moc/' storing the
# equalizer settings when the server is shut down.
# Note that there is a "hidden" 'Mixin' setting in that file.
# Mixin (0.0-1.0) is used to determine how much of the original signal is
# used after equalizing.  0 means to only use the equalized sound, while 1
# effectively disabled the mixer.  The default is 0.25.
#Equalizer_SaveState = yes

# Show files with dot at the beginning?
#ShowHiddenFiles = no

# Hide file name extensions?
#HideFileExtension = no

# Show file format in menu?
ShowFormat = no

# Show file time in menu?  Possible values: 'yes', 'no' and 'IfAvailable'
# (meaning show the time only when it is already known, which often works
# faster).
#ShowTime = IfAvailable

# Show time played as a percentage in the time progress bar.
#ShowTimePercent = no

# Values of the TERM environment variable which are deemed to be managed by
# screen(1).  If you are setting a specific terminal using screen(1)'s
# '-T <term>' option, then you will need to add 'screen.<term>' to this list.
# Note that this is only a partial test; the value of the WINDOW environment
# variable must also be a number (which screen(1) sets).
#ScreenTerms = screen:screen-w:vt100

# Values of the TERM environment variable which are deemed to be xterms.  If
# you are using MOC within screen(1) under an xterm, then add screen(1)'s
# TERM setting here as well to cause MOC to update the xterm's title.
#XTerms = xterm
#XTerms += xterm-colour:xterm-color
#XTerms += xterm-256colour:xterm-256color
#XTerms += rxvt:rxvt-unicode
#XTerms += rxvt-unicode-256colour:rxvt-unicode-256color
#XTerms += eterm

# Theme file to use.  This can be absolute path or relative to
# /usr/share/moc/themes/ (depends on installation prefix) or
# ~/.moc/themes/ .
#
# Example:    Theme = laras_theme
#
# Theme = yellow_red_theme
Theme = black_red_white

# The theme used when running on an xterm.
#
# Example:    XTermTheme = transparent-background
#
#XTermTheme =

# Should MOC try to autoload the default lyrics file for an audio?  (The
# default lyrics file is a text file with the same file name as the audio
# file name with any trailing "extension" removed.)
#AutoLoadLyrics = yes

# MOC directory (where pid file, socket and state files are stored).
# You can use ~ at the beginning.
#MOCDir = ~/.moc

# Use mmap() to read files.  mmap() is much slower on NFS.
#UseMMap = no

# Use MIME to identify audio files.  This can make for slower loading
# of playlists but is more accurate than using "extensions".
#UseMimeMagic = no

# Assume this encoding for ID3 version 1/1.1 tags (MP3 files).  Unlike
# ID3v2, UTF-8 is not used here and MOC can't guess how tags are encoded.
# Another solution is using librcc (see the next option).  This option is
# ignored if UseRCC is set to 'yes'.
#ID3v1TagsEncoding = WINDOWS-1250

# Use librcc to fix ID3 version 1/1.1 tags encoding.
#UseRCC = yes

# Use librcc to filenames and directory names encoding.
#UseRCCForFilesystem = yes

# When this option is set the player assumes that if the encoding of
# ID3v2 is set to ISO-8859-1 then the ID3v1TagsEncoding is actually
# that and applies appropriate conversion.
#EnforceTagsEncoding = no

# Enable the conversion of filenames from the local encoding to UTF-8.
#FileNamesIconv = no

# Enable the conversion of the xterm title from UTF-8 to the local encoding.
#NonUTFXterm = no

# Should MOC precache files to assist gapless playback?
#Precache = yes

# Remember the playlist after exit?
#SavePlaylist = yes

# When using more than one client (interface) at a time, do they share
# the playlist?
#SyncPlaylist = yes

# Choose a keymap file (relative to '~/.moc/' or using an absolute path).
# An annotated example keymap file is included ('keymap.example').
#
# Example:    Keymap = my_keymap
#
Keymap = keymap

# Use ASCII rather than graphic characters for drawing lines.  This
# helps on some terminals.
#ASCIILines = no

# FastDirs, these allow you to jump directly to a directory, the key
# bindings are in the keymap file.
#
# Examples:   Fastdir1 = /mp3/rock
#             Fastdir2 = /mp3/electronic
#             Fastdir3 = /mp3/rap
#             Fastdir4 = /mp3/etc
#
Fastdir1 = /media/marvin/_datasets/confidential/
#Fastdir2 =
#Fastdir3 =
#Fastdir4 =
#Fastdir5 =
#Fastdir6 =
#Fastdir7 =
#Fastdir8 =
#Fastdir9 =
#Fastdir10 =

# How fast to seek (in number of seconds per keystroke).  The first
# option is for normal seek and the second for silent seek.
#SeekTime = 1
#SilentSeekTime = 5

# PreferredDecoders allows you to specify which decoder should be used
# for any given audio format.  It is a colon-separated list in which
# each entry is of the general form 'code(decoders)', where 'code'
# identifies the audio format and 'decoders' is a comma-separated list
# of decoders in order of preference.
#
# The audio format identifier may be either a filename extension or a
# MIME media type.  If the latter, the format is 'type/subtype' (e.g.,
# 'audio/flac').  Because different systems may give different MIME
# media types, any 'x-' prefix of the subtype is ignored both here and
# in the actual file MIME type (so all combinations of 'audio/flac' and
# 'audio/x-flac' match each other).
#
# For Internet streams the matching is done on MIME media type and on
# actual content.  For files the matches are made on MIME media type
# (if the 'UseMimeMagic' option is set) and on filename extension.  The
# MIME media type of a file is not determined until the first entry for
# MIME is encountered in the list.
#
# The matching is done in the order of appearance in the list with any
# entries added from the command line being matched before those listed
# here.  Therefore, if you place all filename extension entries before
# all MIME entries you will speed up MOC's processing of directories
# (which could be significant for remote file systems).
#
# The decoder list may be empty, in which case no decoders will be used
# for files (and files with that audio format ignored) while Internet
# streams will be assessed on the actual content.  Any decoder position
# may contain an asterisk, in which case any decoder not otherwise listed
# which can handle the audio format will be used.  It is not an error to
# list the same decoder twice, but neither does it make sense to do so.
#
# If you have a mix of audio and non-audio files in your directories, you
# may wish to include entries at top of the list which ignore non-audio
# files by extension.
#
# In summary, the PreferredDecoders option provides fine control over the
# type of matching which is performed (filename extension, MIME media
# type and streamed media content) and which decoder(s) (if any) are used
# based on the option's list entries and their ordering.
#
# Examples:   aac(aac,ffmpeg)             first try FAAD2 for AACs then FFmpeg
#             mp3()                       ignore MP3 files
#             wav(*,sndfile)              use sndfile for WAV as a last resort
#             ogg(vorbis,*):flac(flac,*)  try Xiph decoders first
#             ogg():audio/ogg()           ignore OGG files, and
#                                         force Internet selection by content
#             gz():html()                 ignore some non-audio files
#
# Any unspecified audio formats default to trying all decoders.
# Any unknown (or misspelt) drivers are ignored.
# All names are case insensitive.
# The default setting reflects the historical situation modified by
# the experience of users.
#
#PreferredDecoders  = aac(aac,ffmpeg):m4a(ffmpeg)
#PreferredDecoders += mpc(musepack,*,ffmpeg):mpc8(musepack,*,ffmpeg)
#PreferredDecoders += sid(sidplay2):mus(sidplay2)
#PreferredDecoders += wav(sndfile,*,ffmpeg)
#PreferredDecoders += wv(wavpack,*,ffmpeg)
#PreferredDecoders += audio/aac(aac):audio/aacp(aac):audio/m4a(ffmpeg)
#PreferredDecoders += audio/wav(sndfile,*)

# The following PreferredDecoders attempt to handle the ambiguity surrounding
# container types such as OGG for files.  The first two entries will force
# a local file to the correct decoder (assuming the .ogg file contains Vorbis
# audio), while the MIME media types will cause Internet audio streams to
# be assessed on content (which may be either Vorbis or Speex).
#
#PreferredDecoders += ogg(vorbis,*,ffmpeg):oga(vorbis,*,ffmpeg):ogv(ffmpeg)
#PreferredDecoders += application/ogg(vorbis):audio/ogg(vorbis)
#PreferredDecoders += flac(flac,*,ffmpeg)
#PreferredDecoders += opus(ffmpeg)
#PreferredDecoders += spx(speex)

# Which resampling method to use.  There are a few methods of resampling
# sound supported by libresamplerate.  The default is 'Linear') which is
# also the fastest.  A better description can be found at:
#
#    http://www.mega-nerd.com/libsamplerate/api_misc.html#Converters
#
# but briefly, the following methods are based on bandlimited interpolation
# and are higher quality, but also slower:
#
#    SincBestQuality   - really slow (I know you probably have an xx GHz
#                        processor, but it's still not enough to not see
#                        this in the top output :)  The worst case
#                        Signal-to-Noise Ratio is 97dB.
#    SincMediumQuality - much faster.
#    SincFastest       - the fastest bandlimited interpolation.
#
# And these are lower quality, but much faster methods:
#
#    ZeroOrderHold - really poor quality, but it's really fast.
#    Linear - a bit better and a bit slower.
#
#ResampleMethod = Linear

# Always use this sample rate (in Hz) when opening the audio device (and
# resample the sound if necessary).  When set to 0 the device is opened
# with the file's rate.
#ForceSampleRate = 0

# By default, even if the sound card reports that it can output 24bit samples
# MOC converts 24bit PCM to 16bit.  Setting this option to 'yes' allows MOC
# to use 24bit output.  (The MP3 decoder, for example, uses this format.)
# This is disabled by default because there were reports that it prevents
# MP3 files from playing on some soundcards.
#Allow24bitOutput = no

# Use realtime priority for output buffer thread.  This will prevent gaps
# while playing even with heavy load.  The user who runs MOC must have
# permissions to set such a priority.  This could be dangerous, because it
# is possible that a bug in MOC will freeze your computer.
#UseRealtimePriority = no

# The number of audio files for which MOC will cache tags.  When this limit
# is reached, file tags are discarded on a least recently used basis (with
# one second resolution).  You can disable the cache by giving it a size of
# zero.  Note that if you decrease the cache size below the number of items
# currently in the cache, the number will not decrease immediately (if at
# all).
#TagsCacheSize = 256

# Number items in the playlist.
#PlaylistNumbering = yes

# Main window layouts can be configured.  You can change the position and
# size of the menus (directory and playlist).  You have three layouts and
# can switch between then using the 'l' key (standard mapping).  By default,
# only two layouts are configured.
#
# The format is as follows:
#
#     - Each layout is described as a list of menu entries.
#     - Each menu entry is of the form:
#
#           menu(position_x, position_y, width, height)
#
#       where 'menu' is either 'directory' or 'playlist'.
#     - The parameters define position and size of the menu.  They can
#       be absolute numbers (like 10) or a percentage of the screen size
#       (like 45%).
#     - 'width' and 'height' can have also value of 'FILL' which means
#        fill the screen from the menu's position to the border.
#     - Menus may overlap.
#
# You must describe at least one menu (default is to fill the whole window).
# There must be at least one layout (Layout1) defined; others can be empty.
#
# Example:    Layout1 = playlist(50%,50%,50%,50%)
#             Layout2 = ""
#             Layout3 = ""
#
#             Just one layout, the directory will occupy the whole
#             screen, the playlist will have 1/4 of the screen size
#             and be positioned at lower right corner.  (Note that
#             because the playlist will be hidden by the directory
#             you will have to use the TAB key to make the playlist
#             visible.)
#
# Example:    Layout1 = playlist(0,0,100%,10):directory(0,10,100%,FILL)
#
#             The screen is split into two parts: playlist at the top
#             and the directory menu at the bottom.  Playlist will
#             occupy 10 lines and the directory menu the rest.
#
#Layout1 = directory(0,0,50%,100%):playlist(50%,0,FILL,100%)
#Layout2 = directory(0,0,100%,100%):playlist(0,0,100%,100%)
#Layout3 = ""

# When the song changes, should the menu be scrolled so that the currently
# played file is visible?
#FollowPlayedFile = yes

# What to do if the interface was started and the server is already playing
# something from the playlist?  If CanStartInPlaylist is set to 'yes', the
# interface will switch to the playlist.  When set to 'no' it will start
# from the last directory.
#CanStartInPlaylist = yes

# Executing external commands (1 - 10) invoked with key commands (F1 - F10
# by default).
#
# Some arguments are substituted before executing:
#
#     %f - file path
#     %i - title made from tags
#     %S - start block mark (in seconds)
#     %E - end block mark (in seconds)
#
# Data from tags can also be substituted:
#
#     %t - title
#     %a - album
#     %r - artist
#     %n - track
#     %m - time of the file (in seconds)
#
# The parameters above apply to the currently selected file.  If you change
# them to capital letters, they are taken from the file currently playing.
#
# Programs are run using execv(), not a shell, so you can't do things like
# redirecting the output to a file.  The command string is split using blank
# characters as separators; the first element is the command to be executed
# and the rest are its parameters, so if you use "echo Playing: %I" we run
# program 'echo' (from $PATH) with 2 parameters: the string 'Playing:' and
# the title of the file currently playing.  Even if the title contains
# spaces, it's still one parameter and it's safe if it contains `rm -rf /`.
#
# Examples:   ExecCommand1 = "cp %f /mnt/usb_drive"
#             ExecCommand2 = "/home/joe/now_playing %I"
#
#ExecCommand1 =
#ExecCommand2 =
#ExecCommand3 =
#ExecCommand4 =
#ExecCommand5 =
#ExecCommand6 =
#ExecCommand7 =
#ExecCommand8 =
#ExecCommand9 =
#ExecCommand10 =

# Display the cursor in the line with the selected file.  Some braille
# readers (the Handy Tech modular series ZMU 737, for example) use the
# cursor to focus and can make use of it to present the file line even
# when other fields are changing.
#UseCursorSelection = no

# Set the terminal title when running under xterm.
#SetXtermTitle = yes

# Set the terminal title when running under screen(1).  If MOC can detect
# that it is running under screen(1), then it will set an appropriate
# title (see description of ScreenTerms above).  However, if multiple
# levels of screen management are involved, detection might fail and this
# could cause a screen upset.  In that situation you can use this option
# to force screen titles off.
#SetScreenTitle = yes

# Display full paths instead of just file names in the playlist.
#PlaylistFullPaths = yes

# The following setting describes how block markers are displayed in
# the play time progress bar.  Its value is a string of exactly three
# characters.  The first character is displayed in a position which
# corresponds to the time marked as the start of a block and the last
# character to the time marked as the end of the block.  The middle
# character is displayed instead if both the start and the end of the block
# would fall in the same position (within the resolution of the interface).
# You can turn off the displaying of these block marker positions by using
# three space characters.
#BlockDecorators = "`\"'"

# How long (in seconds) to leave a message displayed on the screen.
# Setting this to a high value allows you to scroll through the messages
# using the 'hide_message' key.  Setting it to zero means you'll have to
# be quick to see any message at all.  Any new messages will be queued up
# and displayed after the current message's linger time expires.
#MessageLingerTime = 3

# Does MOC display a prefix on delayed messages indicating
# the number of queued messages still to be displayed?
#PrefixQueuedMessages = yes

# String to append to the queued message count if any
# error messages are still waiting to be displayed.
#ErrorMessagesQueued = "!"

# Self-describing ModPlug options (with 'yes' or 'no' values).
#ModPlug_Oversampling = yes
#ModPlug_NoiseReduction = yes
#ModPlug_Reverb = no
#ModPlug_MegaBass = no
#ModPlug_Surround = no

# ModPlug resampling mode.
# Valid values are:
#
#     FIR -      8 tap fir filter (extremely high quality)
#     SPLINE -   Cubic spline interpolation (high quality)
#     LINEAR -   Linear interpolation (fast, good quality)
#     NEAREST -  No interpolation (very fast, extremely bad sound quality)
#
#ModPlug_ResamplingMode = FIR

# Other self-describing ModPlug audio characteristic options.
# (Note that the 32 bit sample size seems to be buggy.)
#ModPlug_Channels = 2               # 1 or 2 channels
#ModPlug_Bits = 16                  # 8, 16 or 32 bits
#ModPlug_Frequency = 44100          # 11025, 22050, 44100 or 48000 Hz
#ModPlug_ReverbDepth = 0            # 0 (quiet) to 100 (loud)
#ModPlug_ReverbDelay = 0            # Delay in ms (usually 40-200ms)
#ModPlug_BassAmount = 0             # 0 (quiet) to 100 (loud).
#ModPlug_BassRange = 10             # Cutoff in Hz (10-100).
#ModPlug_SurroundDepth = 0          # Surround level 0(quiet)-100(heavy).
#ModPlug_SurroundDelay = 0          # Surround delay in ms, usually 5-40ms.
#ModPlug_LoopCount = 0              # 0 (never), n (times) or -1 (forever)

# Self-describing TiMidity audio characteristic options.
#TiMidity_Rate = 44100              # Between 8000 and 48000
#TiMidity_Bits = 16                 # 8 or 16
#TiMidity_Channels = 2              # 1 or 2
#TiMidity_Volume = 100              # 0 to 800

# You can setup a TiMidity-Config-File here.
# Leave it unset to use library defaults (/etc/timidity.cfg mostly).
# Setting it to 'yes' also uses the library defaults.
# Set it to 'no' if you don't have any configuration file.
# Otherwise set it to the name of a specific file.
TiMidity_Config = no

# Self-describing SidPlay2 audio characteristic options.
#SidPlay2_DefaultSongLength = 180   # If not in database (in seconds)
#SidPlay2_MinimumSongLength = 0     # Play at least n (in seconds)
#SidPlay2_Frequency = 44100         # 4000 to 48000
#SidPlay2_Bits = 16                 # 8 or 16
#SidPlay2_Optimisation = 0          # 0 (worst quality) to 2 (best quality)

# Set path to a HVSC-compatible database (if not set, database is disabled).
#SidPlay2_Database =

# SidPlay2 playback Mode:
#
#     "M": Mono (best for many SIDs)
#     "S": Stereo
#     "L"/"R": Left / Right
#
#SidPlay2_PlayMode = "M"

# Use start-song information from SID ('yes') or start at first song
# ('no').  Songs before the start-song won't be played.
#SidPlay2_StartAtStart = yes

# Play sub-tunes.
#SidPlay2_PlaySubTunes = yes

# Run the OnSongChange command when a new song starts playing.
# Specify the full path (i.e. no leading '~') of an executable to run.
# Arguments will be passed, and you can use the following escapes:
#
#     %a artist
#     %r album
#     %f filename
#     %t title
#     %n track
#     %d file duration in XX:YY form
#     %D file duration, number of seconds
#
# No pipes/redirects can be used directly, but writing a shell script
# can do the job.
#
# Example:    OnSongChange = "/home/jack/.moc/myscript %a %r"
#
#OnSongChange =

# If RepeatSongChange is 'yes' then MOC will execute the command every time
# a song starts playing regardless of whether or not it is just repeating.
# Otherwise the command will only be executed when a different song is
# started.
#RepeatSongChange = no

# Run the OnStop command (full path, no arguments) when MOC changes state
# to stopped (i.e., when user stopped playing or changes a song).
#
# Example:    OnStop = "/home/jack/.moc/myscript_on_stop"
#
#OnStop =

# This option determines which song to play after finishing all the songs
# in the queue.  Setting this to 'yes' causes MOC to play the song which
# follows the song being played before queue playing started. If set to
# 'no', MOC will play the song following the last song in the queue if it
# is in the playlist.  The default is 'yes' because this is the way other
# players usually behave.  (Note that this option previously took the
# values 1 and 0; these are now deprecated in favour of 'yes' and 'no'.)
#QueueNextSongReturn = yes
