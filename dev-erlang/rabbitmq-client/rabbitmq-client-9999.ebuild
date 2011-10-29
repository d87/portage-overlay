# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools mercurial

DESCRIPTION="AMQP client library for Erlang/OTP based on RabbitMQ"
HOMEPAGE="https://github.com/rabbitmq/rabbitmq-tutorials/tree/master/erlang"
EHG_REPO_URI="http://hg.rabbitmq.com/rabbitmq-erlang-client/file/default"

SRV_VER="2.6.1"
SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-server/v${SRV_VER}/rabbitmq-server-${SRV_VER}.tar.gz"
ERL_DIR="/usr/$(get_libdir)/erlang/lib"

LICENSE="MPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/autoconf-2.64
	app-arch/zip
	dev-lang/erlang
	net-misc/rabbitmq-server
	"
RDEPEND="dev-lang/erlang
	net-misc/rabbitmq-server
	"

# pkg_setup() {
	# SRV_PVR=$(best_version net-misc/rabbitmq-server)
	# export SRV_VER=$(echo ${SRV_PVR} |sed -e "s/^.\+\/rabbitmq-server-//g" -e "s/-r[0-9]\+$//g")
	# export SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-server/v${SRV_VER}/rabbitmq-server-${SRV_VER}.tar.gz"
	# einfo "Found rabbitmq-server v${SRV_VER}"
# }

	
src_prepare() {
	unpack "rabbitmq-server-${SRV_VER}.tar.gz"
	mv "${WORKDIR}/${PF}/rabbitmq-server-${SRV_VER}" "${WORKDIR}/rabbitmq-server"
	
	einfo "Pointing to rabbitmq_server headers"
	sed -i -e "s/rabbit_common/rabbitmq_server/g" "${WORKDIR}/${PF}/include/amqp_client.hrl" || die "sed died"
}
	
src_install() {
	emake DESTDIR="${ED}" || "make failed"
	LIBNAME="amqp_client"
	dodir "${ERL_DIR}/${LIBNAME}"
	dodir "${ERL_DIR}/${LIBNAME}/ebin"
	dodir "${ERL_DIR}/${LIBNAME}/include"
	
	insinto "${ERL_DIR}/${LIBNAME}/ebin"
	doins ebin/*.beam
	doins ebin/*.app

	insinto "${ERL_DIR}/${LIBNAME}/include"
        doins include/*

	ewarn "Built against rabbitmq-server v${SRV_VER}"
}
				