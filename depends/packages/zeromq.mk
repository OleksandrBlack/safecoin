ifeq ($(host_os),mingw32)
$(package)_version=4.3.3
$(package)_download_path=https://github.com/zeromq/libzmq/releases/download/v$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.gz
$(package)_sha256_hash=9d9285db37ae942ed0780c016da87060497877af45094ff9e1a1ca736e3875a2

define $(package)_set_vars
  $(package)_build_env+=
  $(package)_config_opts=--enable-shared=false --enable-static --host=x86_64-w64-mingw32
  $(package)_config_opts += --without-libgssapi_krb5 --without-pgm --without-norm --without-vmci
  $(package)_config_opts += --disable-libunwind --disable-radix-tree --without-gcov --disable-dependency-tracking
  $(package)_config_opts += --disable-drafts --enable-option-checking
  $(package)_config_opts_mingw32=--enable-shared=false --enable-static --prefix=$(host_prefix) --host=x86_64-w64-mingw32 --disable-curve --disable-curve-keygen --disable-perf
  $(package)_cflags=-Wno-error -Wall -Wno-pedantic-ms-format -DLIBCZMQ_EXPORTS -DZMQ_DEFINED_STDINT -lws2_32 -liphlpapi -lrpcrt4
  $(package)_conf_tool=./configure
endef
else
package=zeromq
$(package)_version=4.3.3
$(package)_download_path=https://github.com/zeromq/libzmq/releases/download/v$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.gz
$(package)_sha256_hash=9d9285db37ae942ed0780c016da87060497877af45094ff9e1a1ca736e3875a2

define $(package)_set_vars
  $(package)_config_opts=--without-docs --disable-shared --disable-curve --disable-curve-keygen --disable-perf
  $(package)_config_opts += --without-libgssapi_krb5 --without-pgm --without-norm --without-vmci
  $(package)_config_opts += --disable-libunwind --disable-radix-tree --without-gcov --disable-dependency-tracking
  $(package)_config_opts += --disable-drafts --enable-option-checking
  $(package)_config_opts_linux=--with-pic
  $(package)_cxxflags=-std=c++11
endef
endif

ifeq ($(host_os),mingw32)
define $(package)_preprocess_cmds
  cd $($(package)_build_subdir); ./autogen.sh
endef
define $(package)_config_cmds
  $($(package)_conf_tool) $($(package)_config_opts) CFLAGS="-Wno-error -Wall -Wno-pedantic-ms-format -DLIBCZMQ_EXPORTS -DZMQ_DEFINED_STDINT -lws2_32 -liphlpapi -lrpcrt4"
endef
else
define $(package)_config_cmds
  $($(package)_autoconf)
endef
endif

define $(package)_build_cmds
  $(MAKE) src/libzmq.la
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install-libLTLIBRARIES install-includeHEADERS install-pkgconfigDATA
endef

define $(package)_postprocess_cmds
  rm -rf bin share lib/*.la
endef
