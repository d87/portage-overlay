
EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="uMurmur is a minimalistic version of Mumble server."
HOMEPAGE="http://code.google.com/p/umurmur/"
SRC_URI="http://umurmur.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="dev-libs/openssl
	dev-libs/libconfig"

pkg_setup() {
	enewgroup umurmur
	enewuser umurmur -1 -1 -1 umurmur
}

src_configure() {
	sed -i -e 's/# EXTRA_LDFLAGS:=-lcrypto -lssl/EXTRA_LDFLAGS:=-lcrypto -lssl/' src/Makefile || die "Sed failed!"
}

src_compile() {
	cd src
	emake || die
}

src_install() {
	echo "OOOOOPPP ${PWD}"
	dobin umurmurd || die

	insinto /etc
	newins ../umurmur.conf.example umurmur.conf ||die
}
