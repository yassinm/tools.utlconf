UTLAPPS_rust_init(){
  alias rust-env="UTLAPPS_rust_env"
  alias rust-rlsvscode="UTLAPPS_rust_rlsvscode"
}

UTLAPPS_rust_vars(){
  export RLS_ROOT="${UTL3RDP_GITHUB}/rust-lang/rls"
  export LD_LIBRARY_PATH=${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib
  export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
}

UTLAPPS_rust_rlsvscode(){
  local rlsDir="${UTL3RDP_GITHUB}/rust-lang/rls_vscode"
  rm -f ${HOME}/.vscode/extensions/rls_vscode
  ln -s ${rlsDir} ${HOME}/.vscode/extensions/rls_vscode
}

UTLAPPS_rust_env(){
  UTLAPPS_rust_vars

  if [ -z "${UTL3RDP_RUST}" ] ; then
    source $HOME/.cargo/env
    export UTL3RDP_RUST="$HOME/.cargo"
  fi
}
