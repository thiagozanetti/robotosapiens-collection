function check_for_virtual_env {
  [ -d .git ] || git rev-parse --git-dir &> /dev/null

  if [ $? -eq 0 ]; then
    local ENV_BASENAME=`basename \`pwd\``

    # suppress erros on zsh
    exec >/dev/null
    exec 2>/dev/null

    ls -d -- $WORKON_HOME/$ENV_BASENAME-*

    if [ $? -eq 0 ]; then
      local ENV_NAME=`basename \`ls -d -- $WORKON_HOME/$ENV_BASENAME-*\``
    fi

    # restore ttys
    exec >/dev/tty
    exec 2>/dev/tty
    
  if ! [ -e $WORKON_HOME/$ENV_NAME/bin/activate ]; then
      local VENV_FILE=`basename \`pwd\``\.venv

      if [ -f $VENV_FILE ]; then
        ENV_NAME=`cat $VENV_FILE`
      else
        unset ENV_NAME
      fi
    fi

    if [ $ENV_NAME ] && [ "${VIRTUAL_ENV##*/}" != $ENV_NAME ] && [ -e $WORKON_HOME/$ENV_NAME/bin/activate ]; then
      workon $ENV_NAME && export CD_VIRTUAL_ENV=$ENV_NAME
    fi
  elif [ $CD_VIRTUAL_ENV ]; then
    deactivate && unset CD_VIRTUAL_ENV
  fi
}

function cd {
  builtin cd "$@" && check_for_virtual_env
}

check_for_virtual_env
