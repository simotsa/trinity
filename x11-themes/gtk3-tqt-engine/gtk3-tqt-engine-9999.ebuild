# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="gtk3-tqt-engine"

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
	local pro  libdirs d

	trinity-base_src_prepare

	for d in $(get-trinity-libdirs); do
		libdirs+=" -L$d"
	done

	for d in $(get_all_libdirs); do
		libdirs+=" -L/usr/tqt3/$d"
	done
	cp /usr/share/aclocal/libtool.m4 admin/libtool.m4.in
	( cd admin && libtoolize)
	echo 'AC_PREREQ(2.1)' >> configure.in.in
	echo 'AM_INIT_AUTOMAKE(1.9)' >> configure.in.in

	export PATH=$TDEDIR/bin/:$PATH
	make -f admin/Makefile.common
}

src_configure() {
	export PATH=$TDEDIR/bin/:$PATH
	econf $(use_with arts) --with-qt-libraries=/usr/tqt3/lib64
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR=${D}
}
