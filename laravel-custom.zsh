function laravel_prompt_info {
  local version  

  if [[ -x artisan ]]; then
    version=$(echo "${$(./artisan --version)[(w)4]}") || return 0
    echo "${ZSH_THEME_LARAVEL_PROMPT_PREFIX}${version}${ZSH_THEME_LARAVEL_PROMPT_SUFFIX}"
  fi
}
