function nvm_prompt_info {
  if [[ -a $PWD/package.json  ]]; then
    setopt +o nomatch

    [ -f "$HOME/.nvm/nvm.sh" ] || return
    local nvm_prompt nvm_v node_v npm_v bower_v gulp_v typings_v ts_v

    nvm_v=$(nvm --version 2>/dev/null)
    node_v=$(node -v 2>/dev/null)
    npm_v=$(npm -v 2>/dev/null)
    yarn_v=$(yarn -v 2>/dev/null)

    if [[ "${nvm_v}x" == "x" || "${node_v}x" == "x" || "${npm_v}x" == "x" ]] ; then
      echo ""
      return
    fi

    nvm_prompt="nvm:${nvm_v}|node:${node_v:1}|npm:${npm_v}"

    if [[ -f "bun.lockb" ]] ; then
      bun_v=$(bun -v 2>/dev/null)

      if [[ "${bun_v}x" != "x" ]] ; then
        nvm_prompt="${nvm_prompt}|bun:${bun_v}"
      fi
    fi

    if [[ "${yarn_v}x" != "x"  ]] ;  then
      nvm_prompt="${nvm_prompt}|yarn:${yarn_v}"
    fi

    if [[ -d "bower_components" ]] ; then
      bower_v=$(bower -v 2>/dev/null)

      if [[ "${bower_v}x" != "x"  ]] ;  then
        nvm_prompt="${nvm_prompt}|bower:${bower_v}"
      fi
    fi

    if ls gulpfile* &> /dev/null ; then
      gulp_v=$(gulp -v 2>/dev/null)

      if [[ "${gulp_v}x" != "x" ]] ; then
        nvm_prompt="${nvm_prompt}|gulp:${(f)gulp_v[(ws: :)-1]}"
      fi
    fi

    if [[ -f "typings.json" ]] ; then
      typings_v=$(typings -v 2>/dev/null)

      if [[ "${typings_v}x" != "x" ]] ;  then
        nvm_prompt="${nvm_prompt}|typings:${typings_v}"
      fi
    fi

    if [[ -f "tsconfig.json" ]] ; then
      ts_v=$(npx --no tsc -- -v 2>/dev/null)
      if [[ "${ts_v}x" != "x" ]] ; then
        nvm_prompt="${nvm_prompt}|tsc:${ts_v[(ws: :)2]}"
      else
        ts_v=$(tsc -v 2>/dev/null)
        if [[ "${ts_v}x" != "x" ]] ; then
          nvm_prompt="${nvm_prompt}|tsc:${ts_v[(ws: :)2]}"
        fi
      fi
    fi

    nvm_prompt="${nvm_prompt}"

    echo "${ZSH_THEME_NVM_PROMPT_PREFIX}${nvm_prompt}${ZSH_THEME_NVM_PROMPT_SUFFIX}"
  fi
}
