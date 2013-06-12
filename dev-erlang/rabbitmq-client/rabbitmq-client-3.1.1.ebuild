# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools

DESCRIPTION="AMQP client library for Erlang/OTP based on RabbitMQ"
HOMEPAGE="https://github.com/rabbitmq/rabbitmq-tutorials/tree/master/erlang"

SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-erlang-client/v${PV}/amqp_client-${PV}-src.tar.gz
		 http://www.rabbitmq.com/releases/rabbitmq-server/v${PV}/rabbitmq-server-${PV}.tar.gz"
ERL_DIR="/usr/$(get_libdir)/erlang/lib"

LICENSE="MPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/autoconf-2.64
	app-arch/zip
	dev-lang/erlang
	"
RDEPEND="dev-lang/erlang"

#pkg_setup() {
#	SRV_PVR=$(best_version net-misc/rabbitmq-server)
#	export SRV_VER=$(echo ${SRV_PVR} |sed -e "s/^.\+\/rabbitmq-server-//g" -e "s/-r[0-9]\+$//g")
#	export SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-server/v${SRV_VER}/rabbitmq-server-${SRV_VER}.tar.gz"
#	einfo "Found rabbitmq-server v${SRV_VER}"
#}

src_unpack() {
	unpack ${A}
	mv "amqp_client-${PV}-src" "rabbitmq-client-${PV}"
	mv "${WORKDIR}/rabbitmq-server-${PV}" "${WORKDIR}/rabbitmq-server"
#	unzip "${WORKDIR}/${P}/dist/rabbit_common-${PV}.ez" > /dev/null
}

#src_prepare() {
	#einfo "Pointing to rabbitmq_server headers"
	#sed -i -e "s/rabbit_common/rabbitmq_server/g" "${WORKDIR}/${PF}/include/amqp_client.hrl" || die "sed died"
#}

src_install() {
	emake DESTDIR="${ED}" || "make failed"
	LIBNAME="amqp_client-${PV}"
	dodir "${ERL_DIR}/${LIBNAME}"
	dodir "${ERL_DIR}/${LIBNAME}/ebin"
	dodir "${ERL_DIR}/${LIBNAME}/include"

	insinto "${ERL_DIR}/${LIBNAME}/ebin"
	doins ebin/*.beam
	doins ebin/*.app

	insinto "${ERL_DIR}/${LIBNAME}/include"
	doins include/*

	RCOMMON="rabbit_common-${PV}"
	dodir "${ERL_DIR}/${RCOMMON}"
	dodir "${ERL_DIR}/${RCOMMON}/ebin"
	dodir "${ERL_DIR}/${RCOMMON}/include"

	insinto "${ERL_DIR}/${RCOMMON}/ebin"
	doins deps/rabbit_common-*/ebin/*.beam
	doins deps/rabbit_common-*/ebin/*.beam

	insinto "${ERL_DIR}/${RCOMMON}/include"
	doins deps/rabbit_common-*/include/*.hrl

#	ewarn "Built against rabbitmq-server v${SRV_VER}"
}

