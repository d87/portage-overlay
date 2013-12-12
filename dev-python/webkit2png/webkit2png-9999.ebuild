
EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils git-2

DESCRIPTION="webpage screenshots"
HOMEPAGE="https://github.com/AdamN/python-webkit2png/"
SRC_URI=""

LICENSE="MPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

RDEPEND=">=dev-lang/python-2.6
dev-qt/qtwebkit
dev-python/PyQt4"

DEPEND="${RDEPEND}"

EGIT_REPO_URI="git://github.com/AdamN/python-webkit2png.git"

pkg_setup() {
	python_pkg_setup
}

src_compile() {
	distutils_src_compile
}

src_test() {
	testing() {
		# Tests have non-standard assumptions about PYTHONPATH and
		# don't work with usual "build-${PYTHON_ABI}/lib".
		PYTHONPATH="." "$(PYTHON)" tests/runtests.py
	}
	# python_execute_function testing
}

src_install() {
	distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
}
