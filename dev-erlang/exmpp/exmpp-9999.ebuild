# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools git-2

DESCRIPTION="fast and scalable XMPP library written in Erlang/OTP"
HOMEPAGE="https://support.process-one.net/doc/display/EXMPP"
EGIT_REPO_URI="git://git.process-one.net/exmpp/mainline.git"

LICENSE="EPL"
SLOT="0"
KEYWORDS=""
IUSE="examples doc"

DEPEND=">=sys-devel/autoconf-2.64
	dev-lang/erlang
	dev-libs/expat
	dev-libs/libxml2
	dev-libs/openssl
	sys-libs/zlib"
RDEPEND="dev-lang/erlang
		dev-libs/expat
		dev-libs/libxml2
		dev-libs/openssl
		sys-libs/zlib"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --prefix="${EPREFIX}"/usr/$(get_libdir)/erlang/lib --libdir=/usr/$(get_libdir) \
		$(use_enable examples) \
		$(use_enable doc documentation) \
			|| die "econf failed"
}

src_install() {
	emake DESTDIR="${ED}" install || "install failed"
	dodoc README
}

