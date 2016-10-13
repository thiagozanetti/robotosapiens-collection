function nvm_prompt_info {
  [ -f "$HOME/.nvm/nvm.sh" ] || return
  local nvm_prompt nvm_v node_v npm_v bower_v gulp_v typings_v ts_v
  
  nvm_v=$(nvm --version 2>/dev/null)
  node_v=$(node -v 2>/dev/null)
  npm_v=$(npm -v 2>/dev/null)
  bower_v=$(bower -v 2>/dev/null)
  gulp_v=$(gulp -v 2>/dev/null)
  typings_v=$(typings -v 2>/dev/null)
  ts_v=$(tsc -v 2>/dev/null)

  if [[ "${nvm_v}x" == "x" || "${node_v}x" == "x" || "${nvm_v}x" == "x" ]] ; then
    echo ""
    return
  fi

  nvm_prompt="nvm:${nvm_v}|node:${node_v:1}|npm:${npm_v}"

  if [[ "${bower_v}x" != "x" && -d "bower_components" ]] ; then
    nvm_prompt="${nvm_prompt}|bower:${bower_v}"
  fi

  if [[ "${gulp_v}x" != "x" ]] && ls gulpfile* &> /dev/null ; then
    nvm_prompt="${nvm_prompt}|gulp:${(f)gulp_v[(ws: :)-1]}"
  fi

  if [[ "${typings_v}x" != "x" && -f "typings.json" ]] ; then
    nvm_prompt="${nvm_prompt}|typings:${typings_v}"
  fi

  if [[ "${ts_v}x" != "x" && -f "tsconfig.json" ]] ; then
    nvm_prompt="${nvm_prompt}|tsc:${ts_v[(ws: :)2]}"
  fi

  nvm_prompt="[${nvm_prompt}]"

  echo "${ZSH_THEME_NVM_PROMPT_PREFIX}${nvm_prompt}${ZSH_THEME_NVM_PROMPT_SUFFIX}"
}
