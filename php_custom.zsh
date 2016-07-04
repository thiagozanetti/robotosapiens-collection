function php_prompt_info {
  local version  

  if [[ -x $(which php) ]]; then
    version=$(echo "${$(php --version)[(w)2][(ws:-:)1]}") || return 0
    echo "${ZSH_THEME_PHP_PROMPT_PREFIX}${version}${ZSH_THEME_PHP_PROMPT_SUFFIX}"
  fi
}

function php_env_prompt_info {
    local laravel composer php
    laravel=$(laravel_prompt_info)
    composer=$(composer_prompt_info)
    php=$(php_prompt_info)

    if [[ "${laravel}x" == "x" && "${composer}x" == "x" ]]; then
        echo ""
        return
    fi

    echo "${ZSH_THEME_ENV_PHP_PROMPT_PREFIX}${php}${composer}${laravel}${ZSH_THEME_ENV_PHP_PROMPT_SUFFIX}"
}