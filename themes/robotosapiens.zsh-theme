setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

local return_code="%(?..%B$FG[213]%? ↵%f%b)"

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%B$FG[039]%n%f%b'
  PR_USER_OP='%B$FG[039]%#%f%b'
  PR_PROMPT='$FG[039]➛%f'
else # root
  PR_USER='%B$FG[027]%n%f%b'
  PR_USER_OP='%B$FG[027]%#%f%b'
  PR_PROMPT='$FG[027]➛%f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%B$FG[011]%M%f%b' # SSH
else
  PR_HOST='%B$FG[010]%M%f%b' # no SSH
fi

local user_at='%B$FG[120]@%f%b'
local cd_prfx='%B$FG[120]:%f%b'

local user_host="${PR_USER}${user_at}${PR_HOST}"
local current_dir="${cd_prfx}%B$FG[069]%~%f%b"

local user_and_dir="${user_host}${current_dir}"

local rvm_info='$(rvm_prompt_info)'
local git_info='$(git_prompt_info)'
local nvm_info='$(nvm_prompt_info)'
local vnv_info='$(virtualenv_prompt_info)'
local php_info='$(php_env_prompt_info)'
local k8s_info='$(k8s_prompt_info)'

local time_now="%B$FG[046]⏰ %*%f%b"

PROMPT="╭${user_and_dir}
├${git_info}${vnv_info}${nvm_info}${php_info}${rvm_info}${k8s_info}
╰$PR_PROMPT "
RPROMPT="${time_now} ${return_code}"

KUBE_PS1_PREFIX="─$FG[032][%f"
KUBE_PS1_SUFFIX="$FG[032]]%f"
KUBE_PS1_SEPARATOR="$FG[032]|ctx:%f"
KUBE_PS1_DIVIDER="$FG[032]|ns:%f"
KUBE_PS1_SYMBOL_COLOR="32"
KUBE_PS1_CTX_COLOR="32"
KUBE_PS1_NS_COLOR="32"
KUBE_PS1_SYMBOL_USE_IMG=true
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

ZSH_THEME_GIT_PROMPT_PREFIX="$FG[208][git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"

ZSH_THEME_GIT_REF_PREFIX="|ref:"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="|rev:"
ZSH_THEME_GIT_PROMPT_DIRTY="|*"

ZSH_THEME_RVM_PROMPT_PREFIX="─$FG[135]["
ZSH_THEME_RVM_PROMPT_SUFFIX="]%f"

ZSH_THEME_NVM_PROMPT_PREFIX="─$FG[227]["
ZSH_THEME_NVM_PROMPT_SUFFIX="]%f"

ZSH_THEME_VIRTUALENV_PROMPT_PREFIX="─$FG[082]["
ZSH_THEME_VIRTUALENV_PROMPT_SUFFIX="]%f"

ZSH_THEME_ENV_PHP_PROMPT_PREFIX="─$FG[085]["
ZSH_THEME_ENV_PHP_PROMPT_SUFFIX="]%f"

ZSH_THEME_PHP_PROMPT_PREFIX="php:"
ZSH_THEME_PHP_PROMPT_SUFFIX=

ZSH_THEME_LARAVEL_PROMPT_PREFIX="|laravel:"
ZSH_THEME_LARAVEL_PROMPT_SUFFIX=

ZSH_THEME_COMPOSER_PROMPT_PREFIX="|composer:"
ZSH_THEME_COMPOSER_PROMPT_SUFFIX=
}
