# These are commands to run software I don't necessarily want to setup on my
# machine, but could run in a docker container

DOCK_CONFIG_PATH="${HOME}/.dock.json"

function dock() {
  case $1 in
    -h|--help|help)
      echo "
  Usage: dock [application]

    An application to run common daemons

  Commands:

    dock ls|list         List available applications
    dock -h|--help|help  Display this message
    dock [application]   Run the specified application

  Examples:

    $ dock elasticsearch
"
      ;;

    # List configured images
    ls|list)
      cat "${DOCK_CONFIG_PATH}" | jq 'keys | .[]' -M -r
      ;;

    # All else
    *)
      local data="$(cat "${DOCK_CONFIG_PATH}" | jq .$1)"
      # If we have `null`, then we don't have an image for that
      if [ "${data}" == "null" ]; then
        dock --help
        return 1
      fi
      local info="$(echo ${data} | jq '.info')"
      local run=($(echo ${data} | jq '.run' -r))
      # Print out the info object like this: " - ${key} = ${value}"
      echo "${info}" | jq 'to_entries | map([ " - " + .key + " = " + .value]) | .[] | .[]' -M -r
      echo
      # Actually run the command
      ${run[@]}
      ;;
  esac
}

function _dock_complete() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  case "$cur" in
    *)
      COMPREPLY=( $( compgen -W "$(dock ls)" -- "$cur" ) )
      ;;
  esac

  return 0
}

complete -F _dock_complete dock
