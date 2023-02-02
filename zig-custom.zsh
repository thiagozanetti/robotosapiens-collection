function zig_prompt_info {
  setopt +o nomatch

  set -- *.zig
  if [[ -f "$1" ]]; then
    zig_v=$(zig version 2>/dev/null)

    if [[ "${zig_v}x" == "x" ]]; then
      echo ""
      return
    fi

    zig_prompt="zig:${zig_v}"

    # zvm_v=$(zvm --version 2>/dev/null)

    # if [[ "${zvm_v}x" != "x" ]]; then
    #   zig_prompt="zvm:${zvm_v}|${zig_prompt}"
    # fi
  fi

  zig_prompt="${zig_prompt}"

  if [[ "${zig_prompt}x" == "x" ]];  then
    echo ""
    return
  fi

  echo "${ZSH_THEME_ZIG_PROMPT_PREFIX}${zig_prompt}${ZSH_THEME_ZIG_PROMPT_SUFFIX}"
}
