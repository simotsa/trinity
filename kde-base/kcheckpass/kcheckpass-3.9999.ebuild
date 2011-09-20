# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KMNAME="kdebase"
EAPI="3"
inherit trinity-meta

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS=""
IUSE="pam"

RDEPEND="
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pam PAM)
	)

	trinity-meta_src_configure
}
