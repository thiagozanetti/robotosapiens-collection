function js_prompt_info {
  if [[ -f "package.json" ]]; then
    setopt +o nomatch

    node_v=$(node -v 2>/dev/null)
    npm_v=$(npm -v 2>/dev/null)

    if [[ "${node_v}x" == "x" || "${npm_v}x" == "x" ]]; then
      echo ""
      return
    fi

    js_prompt="node:${node_v:1}|npm:${npm_v}"

    if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
      nvm_v=$(nvm --version 2>/dev/null)

      if [[ "${nvm_v}x" != "x" ]]; then
        js_prompt="nvm:${nvm_v}|${js_prompt}"
      fi
    fi

    if [[ -f "bun.lockb" ]]; then
      bun_v=$(bun -v 2>/dev/null)

      if [[ "${bun_v}x" != "x" ]]; then
        js_prompt="${js_prompt}|bun:${bun_v}"
      fi
    fi

    if [[ -f "yarn.lock" ]]; then
      yarn_v=$(yarn -v 2>/dev/null)

      if [[ "${yarn_v}x" != "x"  ]];  then
        js_prompt="${js_prompt}|yarn:${yarn_v}"
      fi
    fi

    if [[ -d "bower_components" ]]; then
      bower_v=$(bower -v 2>/dev/null)

      if [[ "${bower_v}x" != "x"  ]];  then
        js_prompt="${js_prompt}|bower:${bower_v}"
      fi
    fi

    if ls gulpfile* &> /dev/null; then
      gulp_v=$(gulp -v 2>/dev/null)

      if [[ "${gulp_v}x" != "x" ]]; then
        js_prompt="${js_prompt}|gulp:${(f)gulp_v[(ws: :)-1]}"
      fi
    fi

    if [[ -f "typings.json" ]]; then
      typings_v=$(typings -v 2>/dev/null)

      if [[ "${typings_v}x" != "x" ]];  then
        js_prompt="${js_prompt}|typings:${typings_v}"
      fi
    fi

    if [[ -f "tsconfig.json" ]]; then
      ts_v=$(npx --no tsc -- -v 2>/dev/null)
      if [[ "${ts_v}x" != "x" ]]; then
        js_prompt="${js_prompt}|tsc:${ts_v[(ws: :)2]}"
      else
        ts_v=$(tsc -v 2>/dev/null)
        if [[ "${ts_v}x" != "x" ]]; then
          js_prompt="${js_prompt}|tsc:${ts_v[(ws: :)2]}"
        fi
      fi
    fi

    js_prompt="${js_prompt}"

    echo "${ZSH_THEME_JS_PROMPT_PREFIX}${js_prompt}${ZSH_THEME_JS_PROMPT_SUFFIX}"
  fi
}
