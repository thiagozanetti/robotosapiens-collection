export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_prompt_info {
    if [ -n "$VIRTUAL_ENV" ]; then
	local pip_version=`pip --version`
        local venv_info="🐍 python:$(virtualenvwrapper_get_python_version)|pip:${pip_version:4:5}|on:${VIRTUAL_ENV##*/}"
        echo "$ZSH_THEME_VIRTUALENV_PROMPT_PREFIX${venv_info}$ZSH_THEME_VIRTUALENV_PROMPT_SUFFIX"
    fi
}
