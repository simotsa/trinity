# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
TRINITY_MODULE_NAME="kdebase"

inherit trinity-meta

DESCRIPTION="Trinity crash handler gives the user feedback if a program crashed"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gdb"
