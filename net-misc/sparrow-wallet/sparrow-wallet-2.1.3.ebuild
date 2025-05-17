# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Sparrow Bitcoin Wallet"
HOMEPAGE="https://github.com/sparrowwallet/sparrow"
SRC_URI="https://github.com/sparrowwallet/sparrow/releases/download/${PV}/sparrow-${PV}-x86_64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/Sparrow"

src_install() {
    insinto /opt/sparrow
    doins -r *
	fperms 755 /opt/sparrow/bin/Sparrow
    # Optional: Desktop entry
    newicon "${S}/lib/Sparrow.png" sparrow
    make_desktop_entry sparrow "Sparrow Wallet" sparrow "Finance"
    # create symlink in /usr/local/bin
	dosym -r "/opt/sparrow/bin/Sparrow" "usr/bin/sparrow"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
    einfo "Sparrow installed to /opt/sparrow"
    einfo "Run it with: sparrow"
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
