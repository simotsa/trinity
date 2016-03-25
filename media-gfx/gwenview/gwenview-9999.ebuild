# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base

DESCRIPTION="A Trinity Graphics Viewer"
KEYWORDS=""
SLOT="0"
IUSE="arts kipi"

need-trinity 9999


DEPEND="kipi? ( >=media-plugins/kipi-plugins-0.1.0_beta2 )
        media-gfx/exiv2"

RDEPEND="${DEPEND}"

src_prepare() {

	trinity-base_src_prepare

	cp /usr/share/aclocal/libtool.m4 admin/libtool.m4.in
	( cd admin && libtoolize)

	export PATH=$TDEDIR/bin/:$PATH
	make -f admin/Makefile.common
	#sed -i '$d' src/tsthread/tsthread.cpp
}

src_configure() {
	export PATH=$TDEDIR/bin/:$PATH
	econf $(use_with arts) $(use_with kipi ) \
		--with-qt-libraries=/usr/tqt3/lib64 \
		--datadir=$TDEDIR/share
}

src_compile() {
	#rm -rf doc
	#filter-flags -fno-exceptions
	#emake LIBTOOL=libtool

	emake
	echo 'install:' > doc/Makefile
}

src_install() {
	einstall
}
