function rvm_prompt_info {

local rvm_ruby=""

if ${HOME}/.rvm/bin/rvm-prompt &> /dev/null; then # detect user-local rvm installation
  rvm_ruby='$(${HOME}/.rvm/bin/rvm-prompt i v g s)'
elif which rvm-prompt &> /dev/null; then # detect system-wide rvm installation
  rvm_ruby='$(rvm-prompt i v g s)'
elif which rbenv &> /dev/null; then # detect Simple Ruby Version Management
  rvm_ruby='$(rbenv version | sed -e "s/ (set.*$//")'
fi

if [[ "${rvmruby}x" == "x" ]]; then
  echo ""
  return
fi

echo "$ZSH_THEME_RVM_PROMPT_PREFIX${rvm_ruby}$ZSH_THEME_RVM_PROMPT_SUFFIX"

}
