# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
TRINITY_MODULE_NAME="kdeutils"

inherit trinity-meta

DESCRIPTION="Documentaion for kdeutils-derived packages"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="
	>=trinity-base/khelpcenter-${PV}:${SLOT}"
