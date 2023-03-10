##-*-makefile-*-########################################################################################################
# Copyright 2016 - 2023 Inesonic, LLC
# 
# This file is licensed under two licenses.
#
# Inesonic Commercial License, Version 1:
#   All rights reserved.  Inesonic, LLC retains all rights to this software, including the right to relicense the
#   software in source or binary formats under different terms.  Unauthorized use under the terms of this license is
#   strictly prohibited.
#
# GNU Public License, Version 2:
#   This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public
#   License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later
#   version.
#   
#   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#   details.
#   
#   You should have received a copy of the GNU General Public License along with this program; if not, write to the Free
#   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
########################################################################################################################

########################################################################################################################
# Basic build characteristics
#

TEMPLATE = app
QT += core gui widgets svg network printsupport
CONFIG += c++14

########################################################################################################################
# Source files
#

SOURCES = main.cpp

defined(SETTINGS_PRI, var) {
    include($${SETTINGS_PRI})
}

INCLUDEPATH += $${INEAPP_INCLUDE}
INCLUDEPATH += $${INELD_INCLUDE}
INCLUDEPATH += $${INEEQT_INCLUDE}
INCLUDEPATH += $${INECONTAINER_INCLUDE}
INCLUDEPATH += $${INEQCONTAINER_INCLUDE}
INCLUDEPATH += $${INECBE_INCLUDE}
INCLUDEPATH += $${INEM_INCLUDE}
INCLUDEPATH += $${INEUTIL_INCLUDE}
INCLUDEPATH += $${INEUD_INCLUDE}
INCLUDEPATH += $${INEWH_INCLUDE}
INCLUDEPATH += $${INECRYPTO_INCLUDE}
INCLUDEPATH += $${BOOST_INCLUDE}

LIBS += -L$${INEAPP_LIBDIR} -lineapp
LIBS += -L$${INELD_LIBDIR} -lineld
LIBS += -L$${INEEQT_LIBDIR} -lineeqt
LIBS += -L$${INECONTAINER_LIBDIR} -linecontainer
LIBS += -L$${INEQCONTAINER_LIBDIR} -lineqcontainer
LIBS += -L$${INECBE_LIBDIR} -linecbe
LIBS += -L$${INEM_LIBDIR} -linem
LIBS += -L$${INEUTIL_LIBDIR} -lineutil
LIBS += -L$${INEUD_LIBDIR} -lineud
LIBS += -L$${INEWH_LIBDIR} -linewh
LIBS += -L$${INECRYPTO_LIBDIR} -linecrypto

defined(LLVM_PRI, var) {
    include($${LLVM_PRI})
}

defined(INEMAT_PRI, var) {
    include($${INEMAT_PRI})
}

########################################################################################################################
# Operating System
#

unix {
#  Note that some of these libraries may not be part of the OS.  See if we need a distinct PRI file for any of them.
    unix:!macx {
        LIBS += -lrt -ldl
    } else {
        LIBS += -lncurses
    }

    LIBS += -lpthread
    LIBS += -lz
    LIBS += -lm
}

win32 {
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Version.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Psapi.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/shell32.lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Ole32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Uuid.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Kernel32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/User32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/Gdi32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/WinSpool.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/OleAut32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/User32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/ComDlg32.Lib"
    LIBS += "$${WINDOWS_KIT_LIBDIR}/AdvAPI32.Lib"

    !contains(DEFINES, CBE_EXTERNAL_LINKER) {
        contains(QMAKE_TARGET.arch, x86_64) {
            LIBS += "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/DIA SDK/lib/amd64/diaguids.lib"
        } else {
            LIBS += "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/DIA SDK/lib/diaguids.lib"
        }
    }
}

########################################################################################################################
# Locate build intermediate and output products
#

unix:!macx {
    TARGET = aion_core
}

macx {
    TARGET = Aion
    ICON = $${SOURCE_ROOT}/application_icons/icon.icns
#    QMAKE_INFO_PLIST = $${SOURCE_ROOT}/resources/Info.plist
}

win32 {
    TARGET = aion
    RC_ICONS = $${SOURCE_ROOT}/application_icons/icon.ico
}

CONFIG(debug, debug|release) {
    unix:DESTDIR = build/debug
    win32:DESTDIR = build/Debug
} else {
    unix:DESTDIR = build/release
    win32:DESTDIR = build/Release
}

win32 {
    # The use of template libraries causes multiple copies of the same symbols (instantiated by templates) in libraries
    # Unlike real, properly architected operating systems, Windows thinks this is an error.  These linker options tells
    # Windows to perform the link even if this is the case and to suppress the warning messages generated.
    #
    # Unfortunately, Microsoft still insists on issuing a warning indicating the user of the /FORCE option which the
    # linker will not allow you to override.

    QMAKE_LFLAGS += /FORCE:MULTIPLE /IGNORE:4006
}

OBJECTS_DIR = $${DESTDIR}/objects
MOC_DIR = $${DESTDIR}/moc
RCC_DIR = $${DESTDIR}/rcc
UI_DIR = $${DESTDIR}/ui
