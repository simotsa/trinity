# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="kicker applet for Trinity and X clipboard management"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libXfixes"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_XFIXES=ON
	)

	trinity-meta_src_configure
}
