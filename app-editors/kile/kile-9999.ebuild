# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base

DESCRIPTION="A Trinity Tex Viewer"
KEYWORDS="amd64"
IUSE=""
#CMAKE_IN_SOURCE_BUILD=true

need-trinity 14.0.0

SLOT="${TRINITY_VER}"

DEPEND=""
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
	econf $(use_with arts) \
		--with-qt-dir=/usr/tqt3 \
		--prefix=$TDEDIR \
		--datadir=$TDEDIR/share
}

src_compile() {
	emake
}

src_install() {
	einstall
}
