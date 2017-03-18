# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base

DESCRIPTION="A Trinity Graphics Viewer"
KEYWORDS=""
SLOT="0"
IUSE="arts"

RDEPEND="media-libs/libksquirrel"

need-trinity 9999

src_prepare() {

	trinity-base_src_prepare

	cp /usr/share/aclocal/libtool.m4 admin/libtool.m4.in
	( cd admin && libtoolize)

	export PATH=$TDEDIR/bin/:$PATH
	make -f admin/Makefile.common
}

src_configure() {
	export PATH=$TDEDIR/bin/:$PATH
	econf $(use_with arts) \
		--with-qt-dir=/usr/tqt3 \
		--prefix=$TDEDIR --disable-qtopia --disable-kpart
}

src_compile() {
	emake
	echo 'install:' > doc/Makefile
}

src_install() {
	einstall
}
