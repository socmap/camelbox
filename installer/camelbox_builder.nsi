#==========================================================================
#
# TYPE:		NSIS Installer Source File
#
# NAME: 	camelbox.nsi
#
# AUTHOR: 	$LastChangedBy: elspicyjack $
# DATE: 	$LastChangedDate: 2008-03-25 01:38:28 -0700 (Tue, 25 Mar 2008) $
#
# COMMENT:	$Id: multipackage_demo.nsi 47 2008-03-25 08:38:28Z elspicyjack $
#
# The NSIS manual is located at http://nsis.sourceforge.net/Docs.  Parameters 
# used below should have the appropriate section number from the NSIS manual 
# listed somewhere nearby in the comments.
#
# Simple tutorials: http://nsis.sourceforge.net/Simple_tutorials
# 
# For support with this file, please visit the Camelbox mailing list at
# 	http://groups.google.com/group/camelbox
#==========================================================================

# TODO 
# - check the %PATH% first to verify $INSTDIR hasn't already been added to it
# - the installer adds the Camelbox distro to the user's path; maybe make
# it a choice to add it systemwide instead?
# - once you are able to get the distro to install in the directory chosen by
# the user, you'll have to find some way to save the uninstall path, meaning 
# the path that needs to be removed
# - find some way to store a filelist externally, a list of files and variable
# names, which can be plugged into the script at the right times (below)
# - unless you can figure out how to change the Perl paths during the
# install, you need to not give the user the option on where to install
# Camelbox; if they put it someplace funky, it will not work
# - add a checkbox in the download URL page that lets the user keep the archive
# files after the installation is complete
# - add windows shortcuts to important apps and demos
# - start menu/desktop shortcuts?
# - a copy of perl shell for shits and giggles?

#### EXTERNAL FUNCTION SCRIPTS ####
!include "AddToPath.nsh"
!include "nsDialogs.nsh"

#### DEFINES ####
# Section 5.4.1 of the NSIS manual describes !define
# The strftime strings are here:
# http://msdn2.microsoft.com/en-us/library/fe06s4ak.aspx
!define /utcdate RELEASE_VERSION  "%Y.%j.%H%MZ"

# define some macros for use later on
!define CAPTION_TEXT "Camelbox ${RELEASE_VERSION}"
!define INSTALLER_BASE "C:\temp\camelbox-svn\installer"
!define LICENSE_FILE "${INSTALLER_BASE}\License\License.txt"
!define MAIN_ICON "${INSTALLER_BASE}\Icons\camelbox-logo.ico"
#!define BASE_URL "http://manzana/Windows_Software/gtk-archives/"
!define BASE_URL "http://camelbox.googlecode.com/files"
#!define BASE_URL "http://devilduck.qualcomm.com/camelbox"
#!define BASE_URL "http://files.antlinux.com/win/apps/gtk-archives"
!define INSTALL_PATH "C:\camelbox"

#### NSIS OPTIONS ####
# compiler flags
SetCompressor /SOLID lzma 			# 4.8.2.4
SetDatablockOptimize ON				# 4.8.2.6

# set up the installer attributes
AutoCloseWindow FALSE				# 4.8.1.3
CRCCheck ON 						# 4.8.1.12
InstallColors /WINDOWS				# 4.8.1.20
ShowInstDetails SHOW				# 4.8.1.34
SilentInstall NORMAL				# 4.8.1.36

# now set up the installer dialog box, from top top bottom 4.8.1.18
Icon "${MAIN_ICON}"
# caption for this dialog, shown in titlebar 4.8.1.7
Caption "${CAPTION_TEXT}"
# shown at the bottom of this dialog 4.8.1.6
BrandingText "Thanks to Milo for the installer!"
# name of this project 4.8.1.30
Name "${CAPTION_TEXT}"

LicenseText "${CAPTION_TEXT}" 		# 4.8.1.28
LicenseData "${LICENSE_FILE}" 		# 4.8.1.26
#OutFile "C:\temp\camelbox_${RELEASE_VERSION}-way_fucking_alpha.exe" # 4.8.1.31
OutFile "C:\temp\camelbox_${RELEASE_VERSION}-alpha.exe"	# 4.8.1.31
#InstallDir "C:\temp\multipackage_demo_${RELEASE_VERSION}_out" 	# 4.8.1.21
#InstallDir $DESKTOP\demo
InstallDir "${INSTALL_PATH}"

#### PAGES ####
Page License
Page custom ChooseHTTPServer ChooseHTTPServerLeave
Page Components
#Page Directory
Page InstFiles
UninstPage uninstConfirm
UninstPage InstFiles

#### GLOBAL VARIABLES ####
# what file we're going to download
var archivefile
# what the name of the section is, for use with the downloader/unpacker
var sectionname
# dialog label and name
var dialogURL
# the download URL
var DL_URL

#### FUNCTIONS ####

Function ChooseHTTPServer 
# custom page for entering in a download URL
	nsDialogs::Create /NOUNLOAD 1018
	Pop $0
	StrCmp $0 "error" FailBail 0

	${NSD_CreateLabel} 0 0 100% 13u \
		"Please enter the base URL to download files from:"
	pop $0

	${NSD_CreateText} 0 13u 100% 13u ${BASE_URL}
	pop $dialogURL

	${NSD_CreateLabel} 0 30u 100% 13u \
		"(Default URL is ${BASE_URL})"
	pop $0

	${NSD_CreateLabel} 0 45u 100% 13u \
		"You can specify a local/alternate mirror for the Camelbox files here."
	pop $0

	# this always comes last
	nsDialogs::Show
	FailBail:
		# $0 should have already been set by the caller
		DetailPrint "Installer encountered the following fatal error:"
		abort "$0; Aborting..."
FunctionEnd

Function ChooseHTTPServerLeave
# scrape the user's answer out of the text box
	${NSD_GetText} $dialogURL $0
	StrCpy $DL_URL $0
FunctionEnd

# 'download and unpack' function thingy
Function SnarfUnpack
	# pop arguments off of the stack
	pop $sectionname
	pop $archivefile
	# verify the download directory exists
    DetailPrint "Downloading: $DL_URL/$archivefile"
	# do the download;
	# return value = exit code, "OK" if OK
	inetc::get /POPUP "$sectionname" \
		"$DL_URL/$archivefile" "$INSTDIR\$archivefile"
	Pop $0 
	# check for an OK download; continues on success, bails on error
	StrCmp $0 "OK" 0 FailBail
	DetailPrint "Extracting $archivefile"
	untgz::extract -zlzma "$INSTDIR\$archivefile"
	DetailPrint "Unzip status: $R0"
	StrCmp $0 "OK" 0 FailBail
	delete "$INSTDIR\$archivefile"
	# if we've been successful, exit now
	return
	# we should only hit this if called
	FailBail:
		# $0 should have already been set by the caller
		DetailPrint "Installer encountered the following fatal error:"
		abort "'$0'; Aborting..."
FunctionEnd # SnarfUnpack

Function DebugPause
	MessageBox MB_OK "Pausing Installer for Debugging"
FunctionEnd

#### SECTIONS ####

Section "-WriteUninstaller"

	SetOutPath "$INSTDIR"
	CreateDirectory "$INSTDIR\bin"
	writeUninstaller "$INSTDIR\camelbox_uninstaller.exe"
	writeUninstaller "$INSTDIR\bin\camelbox_uninstaller.exe"
	DetailPrint "a little snooze...."
	sleep 500
SectionEnd # WriteUninstaller

; /e in any SectionGroup header means "expanded by default"
Section "Perl 5.10.0 Base Package" perl-core_id
	AddSize 7700 # kilobytes
	push "perl-5.10.0.2008.089.1.tar.lzma"
	SectionGetText ${perl-core_id} $0
	push $0
	Call SnarfUnpack
SectionEnd # "Perl 5.10.0 Base Package"

SectionGroup "Core Gtk2-Perl Packages"
	Section "Core GTK Binaries" gtk-core-bin_id
		AddSize 4500 # kilobytes
		push "gtk-core-bin.2008.089.1.tar.lzma"
		SectionGetText ${gtk-core-bin_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "imagelibs-bin (JPG/PNG/TIFF libraries)" imagelibs-bin_id
		AddSize 240 # kilobytes
		push "imagelibs-bin.2008.089.1.tar.lzma"
		SectionGetText ${imagelibs-bin_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "gtk-support-bin (gettext/libintl/etc.)" gtk-support-bin_id
		AddSize 556 # kilobytes
		push "gtk-support-bin.2008.089.1.tar.lzma"
		SectionGetText ${gtk-support-bin_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "Perl Gtk2-Perl Core Modules" perl-gtk2_id
		AddSize 768 # kilobytes
		push "perl-gtk2.2008.092.1.tar.lzma"
		SectionGetText ${perl-gtk2_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
SectionGroupEnd # "Core Gtk2-Perl Packages"

SectionGroup "Development Packages"
	Section "Minimal GNU for Windows (MinGW) Toolkit" mingw_id
		AddSize 7500 # kilobytes
		push "mingw.2008.089.1.tar.lzma"
		SectionGetText ${mingw_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "Core GTK Development Files" gtk-core-dev_id 
		AddSize 784 # kilobytes
		push "gtk-core-dev.2008.089.1.tar.lzma"
		SectionGetText ${gtk-core-dev_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "Imagelibs Development Files" imagelibs-dev_id 
		AddSize 316 # kilobytes
		push "imagelibs-dev.2008.089.1.tar.lzma"
		SectionGetText ${imagelibs-dev_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "dmake Makefile Processor" dmake_id
		AddSize 70 # kilobytes
		push "dmake.2008.089.1.tar.lzma"
		SectionGetText ${dmake_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "dmake Makefile Processor (extra files)" dmake-extra_id
		AddSize 104 # kilobytes
		push "dmake-extra.2008.089.1.tar.lzma"
		SectionGetText ${dmake-extra_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
SectionGroupEnd # "Development Packages"

SectionGroup "Extra Tools Packages"
	Section "UnxUtilities for Windows" unxutils_id
		AddSize 2000 # kilobytes
		push "unxutils.2008.089.1.tar.lzma"
		SectionGetText ${unxutils_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "7zip Archiver (command line version)" 7zip_id
		AddSize 312 # kilobytes
		push "7zip.2008.089.1.tar.lzma"
		SectionGetText ${7zip_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "LZMA Archiver (command line version)" lzma_id
		AddSize 44 # kilobytes
		push "lzma.2008.089.1.tar.lzma"
		SectionGetText ${lzma_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "imagelibs Utilities" imagelibs-utils_id
		AddSize 276 # kilobytes
		push "imagelibs-utils.2008.089.1.tar.lzma"
		SectionGetText ${imagelibs-utils_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "gettext Utilities" gettext-utils_id
		AddSize 1300 # kilobytes
		push "gettext-utils.2008.089.1.tar.lzma"
		SectionGetText ${gettext-utils_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
SectionGroupEnd # "Extra Tools Packages"

SectionGroup "Extra Perl Modules"
	Section "Perl YAML Module" perl-YAML_id
		AddSize 32 # kilobytes
		push "perl-YAML.2008.089.1.tar.lzma"
		SectionGetText ${perl-YAML_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "Perl LWP libwww-perl Module" perl-LWP_id
		AddSize 204 # kilobytes
		push "perl-LWP.2008.089.1.tar.lzma"
		SectionGetText ${perl-LWP_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
/*
	Section "Moose Post-Modern Object Framework" perl-moose_id
		AddSize  # kilobytes
		push "perl-moose.2008.089.1.tar.lzma"
		SectionGetText ${perl-moose_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
*/
SectionGroupEnd # "Perl Modules"

SectionGroup "Documentation and Examples"
	Section "Perl 5.10.0 HTML Documentation" perl-html_docs_id
		AddSize 2300 # kilobytes
		push "perl-5.10.0-html_docs.2008.089.1.tar.lzma"
		SectionGetText ${perl-html_docs_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "GTK C API HTML/SGML Documentation" gtk-core-doc_id
		AddSize 2200 # kilobytes
		push "gtk-core-doc.2008.089.1.tar.lzma"
		SectionGetText ${gtk-core-doc_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
	Section "Gtk2-Perl Examples" gtk2-perl-examples_id
		AddSize 184 # kilobytes
		push "gtk2-perl-examples.2008.089.1.tar.lzma"
		SectionGetText ${gtk2-perl-examples_id} $0
		push $0
		Call SnarfUnpack
	SectionEnd
SectionGroupEnd # "Documentation and Examples"

SectionGroup /e "Environment Variables"
	Section "Add Camelbox to PATH variable"
		StrCpy $1 "$INSTDIR\bin"
		Push $1
    	DetailPrint "Adding to %PATH%: $1"
		Call AddToPath
	SectionEnd
SectionGroupEnd ; "Environment Variables"

/*
SectionGroup /e "Run Demonstration Scripts"
	Section "perl_swiss_army_knife.pl"
	SectionEnd
	Section "gyroscope.pl"
	SectionEnd
	Section "Gtk2"
	SectionEnd
	Section "Gnome2::Canvas"
	SectionEnd
SectionGroupEnd ; "Demonstration Scripts"
*/

Section "Uninstall"
	# delete the uninstaller first
	DetailPrint "Removing installer files"
	delete "${INSTALL_PATH}\bin\camelbox_uninstaller.exe"
	delete "${INSTALL_PATH}\camelbox_uninstaller.exe"
	# remove the binpath
	StrCpy $1 "${INSTALL_PATH}\bin"
	Push $1
	DetailPrint "Removing from %PATH%: $1"
	Call un.RemoveFromPath
	# then delete the other files/directories
	DetailPrint "Removing ${INSTALL_PATH}"
	RMDir /r ${INSTALL_PATH}
SectionEnd # Uninstall

# blank subsection
#	Section "some-package (extra notes, etc.)"
#		AddSize  # kilobytes
#		push "package-name.YYYY.JJJ.V.tar.lzma"
#		SectionGetText ${some-package_id} $0
#		push $0
#		Call SnarfUnpack
#	SectionEnd

# vim: filetype=nsis paste
