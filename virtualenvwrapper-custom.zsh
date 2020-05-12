export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_prompt_info {
    if [ -n "$VIRTUAL_ENV" ]; then
        local pip_version="$(cut -d' ' -f2 <<<`pip --version`)"
    
        local python_version="$(cut -d' ' -f2 <<<`python --version`)"

        local venv_info="🐍 python:$python_version|pip:$pip_version|on:${VIRTUAL_ENV##*/}"

        echo "$ZSH_THEME_VIRTUALENV_PROMPT_PREFIX${venv_info}$ZSH_THEME_VIRTUALENV_PROMPT_SUFFIX"
    fi
}
