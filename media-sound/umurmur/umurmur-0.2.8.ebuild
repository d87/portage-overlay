
EAPI="4"

inherit eutils autotools

DESCRIPTION="uMurmur is a minimalistic version of Mumble server."
HOMEPAGE="http://code.google.com/p/umurmur/"
SRC_URI="http://umurmur.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/libconfig
	dev-libs/protobuf-c"

#pkg_postinst() {
#	enewgroup umurmur
#	enewuser umurmur -1 -1 /dev/null umurmur
#}


src_configure() {
	econf --with-ssl=openssl || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	# dobin src/umurmurd || die

	dodir /etc/umurmur
	insinto /etc/umurmur
	newins umurmur.conf.example umurmur.conf ||die

	# fperms 0750 /etc/umurmur
	# fperms 0640 /etc/umurmur/umurmur.conf
	# fowners root:umurmur /etc/umurmur /etc/umurmur/umurmur.conf

	newinitd "${FILESDIR}"/init umurmurd
	newconfd "${FILESDIR}"/confd umurmurd
}
