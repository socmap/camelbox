#summary Links to Gtk2-Perl Software
#labels Featured,Phase-Support

[CamelBox Home Page](http://code.google.com/p/camelbox) ::
[Build Start](BuildStart.md) ::
[Build Setup](BuildSetup.md) ::
[Building Perl](BuildPerl.md) ::
[Building Core GTK Libs](BuildCoreGtk.md) ::
[Building Extra GTK Libs](BuildExtraGtk.md) ::
[Building External Gtk2-Perl Apps](BuildExternalApps.md) ::
[Gtk2-Perl Links Page](Gtk2PerlLinks.md) ::
[Camelbox Credits](Credits.md)

See also the [Credits](Credits.md) page for links and licensing details.

### Other Windows Perl Distributions ###
[Strawberry Perl](http://strawberryperl.com/)
  * [Mailing list](http://www.mail-archive.com/win32-vanilla@perl.org/)

### GTK+ Libraries for Windows ###
  * A GTK for Windows page at [gtk.org](http://www.gtk.org/download-windows.html), which includes all of the software needed as well as links to dependencies and some background information on using GTK in Windows.  Updated regularly.
  * [GTK+ and friends pre-compiled binaries for Windows (gnome.org)](http://ftp.acc.umu.se/pub/gnome/binaries/win32), file archive
  * [Dependencies that may be required to build various Gtk2-Perl modules](http://ftp.acc.umu.se/pub/gnome/binaries/win32/dependencies/) (Gtk2::GladeXML, Gnome2::Canvas, etc.), file archive

### Gtk2-Perl ###
  * [Gtk2-Perl homepage (Sourceforge)](http://gtk2-perl.sourceforge.net/)
    * [Gtk2-Perl Win32 page](http://gtk2-perl.sourceforge.net/win32/)

### Windows GTK Applications ###
  * [gladewin32](http://sourceforge.net/project/showfiles.php?group_id=98754), a port of the Glade GUI creation tool for Windows
  * [dlltool](http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/gnu-binutils/dlltool.html), a tool that creates `.dll` files on platforms that need them.

## External Gtk2-Perl Applications ##
A lot of these external applications come from the `Gtk2::Ex` branch in CPAN.  You can perform a [search of CPAN for Gtk2::Ex](http://search.cpan.org/search?m=all&q=Gtk2%3A%3AEx&s=1&n=100) to see a complete list of applications that are available.

  * [Asciio](http://search.cpan.org/perldoc?App::Asciio), an ASCII-art drawing tool (formerly `gpad`)
  * [Axis](http://entropy.homelinux.org/axis/installation.html), a suite of Perl modules that provide an alternative to RAD design tools for database access.
  * [Sprog](http://sprog.sourceforge.net/index.html), a graphical tool which anyone can use to build programs by plugging parts together. In Sprog jargon, the parts are known as 'gears' and they are assembled to make a 'machine'.
  * [GCstar](http://www.gcstar.org/), a manager for collections of information such as books, CD's, DVD's, games, and more.

## Compiling Software on Windows: Libraries and Import Libraries ##
  * [The DLL Import Library Tool](http://mirrors.zoreil.com/webclub.kcom.ne.jp/ma/colinp/win32/tools/dlltool.html)
  * [MinGW: Create Import Libraries](http://www.mingw.org/MinGWiki/index.php/CreateImportLibraries)
  * [MinGW: Create Import Libraries](http://209.85.141.104/search?q=cache:FAJjMH-iZGEJ:www.mingw.org/MinGWiki/index.php/CreateImportLibraries+windows+import+library&hl=en&ct=clnk&cd=17&gl=us&client=firefox-a) (Cached copy)
  * [Mailing list post](http://osdir.com/ml/gnu.libtool.general/2004-04/msg00049.html) on the libtool mailing list about linking against import libraries.
  * [Differences between Unix and Windows](http://docs.python.org/ext/dynamic-linking.html) from python.org.
  * [binutils Manual Page](http://sourceware.org/binutils/docs/binutils/index.html#Top)
    * [objdump](http://sourceware.org/binutils/docs/binutils/objdump.html#objdump)
    * [dlltool](http://sourceware.org/binutils/docs/binutils/dlltool.html#dlltool)
    * [--export-all-symbols](http://sourceware.org/binutils/docs/ld/Options.html#index-g_t_002d_002dexport_002dall_002dsymbols-263) option to ''ld''; this may fix having to build import library files
    * [ld and Win32](http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/gnu-linker/win32.html) page from Red Hat's website

<a href='Hidden comment: 
vi: set filetype=googlecodewiki shiftwidth=2 tabstop=2 paste:
'></a>