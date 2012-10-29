# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

inherit trinity-functions

set-trinityver

DESCRIPTION="tdeartwork meta package - merge this to pull in all tdeartwork-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""

SLOT="$TRINITY_LIVEVER"
IUSE=""

RDEPEND="
	>=trinity-base/tdeartwork-emoticons-${PV}:${SLOT}
	>=trinity-base/tdeartwork-icon-themes-${PV}:${SLOT}
	>=trinity-base/tdeartwork-icewm-themes-${PV}:${SLOT}
	>=trinity-base/tdeartwork-kscreensaver-${PV}:${SLOT}
	>=trinity-base/tdeartwork-kwin-styles-${PV}:${SLOT}
	>=trinity-base/tdeartwork-kworldclock-${PV}:${SLOT}
	>=trinity-base/tdeartwork-sounds-${PV}:${SLOT}
	>=trinity-base/tdeartwork-styles-${PV}:${SLOT}
	>=trinity-base/tdeartwork-wallpapers-${PV}:${SLOT}"