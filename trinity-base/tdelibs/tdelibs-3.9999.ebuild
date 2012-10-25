# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="$PN"

inherit trinity-base multilib

set-trinityver

DESCRIPTION="Trinity libraries needed by all TDE programs."
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
SLOT="$TRINITY_LIVEVER"
KEYWORDS=""
IUSE="alsa avahi arts cups jpeg2k openexr spell tiff lua"

DEPEND="${DEPEND}
	>=x11-libs/qt-3.5.0
	trinity-base/tqtinterface
	>=dev-libs/libxslt-1.1.16
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-6.6
	media-libs/libart_lgpl
	net-dns/libidn
	app-text/ghostscript-gpl
	x11-libs/libXext
	>=dev-libs/openssl-0.9.7d
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libart_lgpl
	net-dns/libidn
	alsa? ( media-libs/alsa-lib )
	arts? ( trinity-base/arts )
	cups? ( >=net-print/cups-1.1.19 )
	jpeg2k? ( media-libs/jasper )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	spell? ( >=app-dicts/aspell-en-6.0.0 >=app-text/aspell-0.60.5 )
	tiff? ( media-libs/tiff )
	lua? ( dev-lang/lua )"
# CHECKME: compilation with avahi

# not supported USE's witch are present in kdelibs:3.5: 
#        acl fam kreberos utempter doc bindist
RDEPEND="${DEPEND}"

#PDEPEND="
#	avahi? ( kde-misc/kdnssd-avahi )"

src_configure() {
	mycmakeargs=(
		-DWITH_LIBIDN=ON
		-DWITH_SSL=ON
		-DWITH_LIBART=ON
		$(cmake-utils_use_with alsa ALSA)
		$(cmake-utils_use_with arts ARTS)
		$(cmake-utils_use_with avahi AVAHI)
		$(cmake-utils_use_with cups CUPS)
		$(cmake-utils_use_with jpeg2k JASPER)
		$(cmake-utils_use_with openexr OPENEXR)
		$(cmake-utils_use_with spell ASPELL)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with lua LUA)
	)

	trinity-base_src_configure
}

src_install() {
	trinity-base_src_install
	
	dodir /etc/env.d
	# KDE implies that the install path is listed first in KDEDIRS and the user
	# directory (implicitly added) to be the last entry. Doing otherwise breaks
	# certain functionality. Do not break this (once again *sigh*), but read the code.
	# KDE saves the installed path implicitly and so this is not needed, /usr
	# is set in ${TDEDIR}/share/config/kdeglobals and so KDEDIRS is not needed.

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${TDEDIR}/${libdir}:${libdirs}"
	done

	cat <<EOF > "${D}"/etc/env.d/45trinitypaths-${SLOT} # number goes down with version upgrade
PATH=${TDEDIR}/bin
ROOTPATH=${TDEDIR}/sbin:${TDEDIR}/bin
LDPATH=${libdirs#:}
MANPATH=${TDEDIR}/share/man
CONFIG_PROTECT="${TDEDIR}/share/config ${TDEDIR}/env ${TDEDIR}/shutdown /usr/share/config"
#KDE_IS_PRELINKED=1
# Excessive flushing to disk as in releases before KDE 3.5.10. Usually you don't want that.
#KDE_EXTRA_FSYNC=1
XDG_DATA_DIRS="${TDEDIR}/share"
EOF

	# Make sure the target for the revdep-rebuild stuff exists. Fixes bug 184441.
	dodir /etc/revdep-rebuild

cat <<EOF > "${D}"/etc/revdep-rebuild/50-trinity
SEARCH_DIRS="${TDEDIR}/bin ${TDEDIR}/lib*"
EOF

	# make documentation help accessible throught symlink
	dosym ${TDEDIR}/share/doc/kde/HTML ${TDEDIR}/share/doc/HTML

	trinity-base_create_tmp_docfiles
	trinity-base_install_docfiles
}

# pkg_postinst () {
# 	ewarn "Don't forget to run env-update after merging kdelibs"
# }