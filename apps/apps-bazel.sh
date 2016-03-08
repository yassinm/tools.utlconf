UTLAPPS_bazel_init(){
  alias bazel-env="UTLAPPS_bazel_env"
  alias bazel-conf="UTLAPPS_bazel_conf"
  alias bazel="${BAZEL_ROOT}/${BAZEL_LATEST}/bin/bazel "
}

UTLAPPS_bazel_env(){
    BAZEL_ROOT="${UTL3RDP_DEV}/bazel"

    # BAZEL_LATEST="bazel-IC-162.2228.15"
    BAZEL_LATEST="bazel-0.4.2"
}

UTLAPPS_bazel_conf(){
  UTLAPPS_bazel_env

  ${BAZEL_ROOT}/${BAZEL_LATEST}-installer-linux-x86_64.sh \
  --bin=${BAZEL_ROOT}/${BAZEL_LATEST}/bin \
  --base=${BAZEL_ROOT}/${BAZEL_LATEST}/.bazel \
  --bazelrc=${BAZEL_ROOT}/${BAZEL_LATEST}/.bazelrc
}
