# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="gtk-qt-engine"

inherit trinity-base

DESCRIPTION="A trinity GTK theme engine using tqt as a backend"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-qt/tqtinterface"
RDEPEND="$DEPEND"

need-trinity 9999

src_unpack() {
	trinity-base_src_unpack
}

src_prepare() {
	cmake ${S}/gtk-qt-engine
	-DTDE_CMAKE_DIR=$TDE_DIR/share/cmake
	-DTDE_INCLUDE_DIR=$TDE_DIR/include/
	-DTDE_LIB_DIR=$TDE_DIR/lib64/
}
