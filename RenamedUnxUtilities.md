#summary Building External Gtk2-Perl Applications
#labels Phase-Implementation

[CamelBox Home Page](http://code.google.com/p/camelbox) ::
[Build Start](BuildStart.md) ::
[Building Perl](BuildPerl.md) ::
[Building Core GTK Libs](BuildCoreGTK.md) ::
[Building Extra GTK Libs](BuildExtraGtk.md) ::
[Building External Gtk2-Perl Apps](BuildExternalApps.md) ::
[Gtk2-Perl Links Page](Gtk2PerlLinks.md)

## Renamed UnxUtilties Binaries ##
The following is a list of files from the [UnxUtilities](http://unxutils.sourceforge.net/) package that have the same names as files that come with Windows
XP. It is recommended that the Windows versions of files with the same name be
seen first in the system; you can either copy/rename the
[UnxUtilities](http://unxutils.sourceforge.net/) commands, or call them with
absolute pathnames in order to use them.

(filename, what it's UnxUtilities equivalent is, why it needs an equivalent)
  * bin/find.exe -> xfind.exe (Windows binary)
  * bin/sort.exe -> xsort.exe (Windows binary)
  * bin/head.exe -> xhead.exe (or rename the HEAD file that's installed from LWP)
  * bin/date.exe -> xdate.exe (Windows cmd.exe shell builtin)

<a href='Hidden comment: 
vi: set filetype=googlecodewiki shiftwidth=2 tabstop=2 paste:
'></a>