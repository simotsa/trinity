# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="4"
TRINITY_MODULE_NAME="kdeartwork"

inherit trinity-meta
DESCRIPTION="Window styles for Trinity"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=trinity-base/kwin-${PV}:${SLOT}"
RDEPEND="$DEPEND"
