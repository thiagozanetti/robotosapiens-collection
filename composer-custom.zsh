function composer_prompt_info {
  local version  

  if [[ -f composer.json && -x $(which composer) ]]; then
    version=$(echo "${$(composer --version)[(w)3]}") || return 0
    echo "${ZSH_THEME_COMPOSER_PROMPT_PREFIX}${version}${ZSH_THEME_COMPOSER_PROMPT_SUFFIX}"
  fi
}
