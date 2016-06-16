function nvm_prompt_info {
  [ -f "$HOME/.nvm/nvm.sh" ] || return
  local nvm_prompt nvm_v node_v npm_v
  nvm_v=$(nvm --version 2>/dev/null)
  node_v=$(node -v 2>/dev/null)
  npm_v=$(npm -v 2>/dev/null)

  if [[ "${nvm_v}x" == "x" || "${node_v}x" == "x" || "${nvm_v}x" == "x" ]] ; then
    echo ""
    return
  fi

  nvm_prompt="[nvm:${nvm_v}|node:${node_v:1}|npm:${npm_v}]"

  echo "${ZSH_THEME_NVM_PROMPT_PREFIX}${nvm_prompt}${ZSH_THEME_NVM_PROMPT_SUFFIX}"
}
