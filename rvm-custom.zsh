function rvm_prompt_info {

  [ -f "Gemfile" ] || [ -f ".ruby-{version,gemset}" ] || return

  local rb rb_version gem_set rvm_version

  if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect user-local rvm installation
    rb=$(${HOME}/.rvm/bin/rvm-prompt i v g s)
  elif which rvm-prompt &> /dev/null; then # detect system-wide rvm installation
    rb='$(rvm-prompt i v g s)'
  elif which rbenv &> /dev/null; then # detect Simple Ruby Version Management
    rb='$(rbenv version | sed -e "s/ (set.*$//")'
  fi

  if ${HOME}/.rvm/bin/rvm &> /dev/null; then
    rvm_version=${$(${HOME}/.rvm/bin/rvm --version 2> /dev/null)[(ws: :)2]}
  fi

  if [[ "${rb}x" == "x" ]]; then
    echo ""
    return
  fi

  rb_version=${rb[(ws:@:)1][(ws:-:)2]}
  gem_set=${rb[(ws:@:)2]}

  if [[ "${gem_set}x" != "x" ]]; then
    rb_version=${rb_version}@${gem_set}
  fi

  if [[ "${rvm_version}x" != "x" ]]; then
    rb_version=rvm:${rvm_version}"|"rb:${rb_version}
  fi

  echo "$ZSH_THEME_RVM_PROMPT_PREFIX${rb_version}$ZSH_THEME_RVM_PROMPT_SUFFIX"
}
