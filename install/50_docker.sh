#!/usr/bin/env bash
is-macos || is-linux || return

# Only if the docker CLI is present.
[[ $(command -v docker) ]] || return

plugins_dir="$(brew --prefix)/lib/docker/cli-plugins"

# Only if brew actually installed CLI plugins (buildx/compose) there.
[[ -e "${plugins_dir}/docker-buildx" || -e "${plugins_dir}/docker-compose" ]] || return

config_dir="${DOCKER_CONFIG:-$HOME/.docker}"
config="${config_dir}/config.json"
mkdir -p "${config_dir}"
[[ -f "${config}" ]] || echo '{}' > "${config}"

tmp="$(mktemp)"
jq --arg dir "${plugins_dir}" \
  '.cliPluginsExtraDirs = ([$dir] + (.cliPluginsExtraDirs // []) | unique)' \
  "${config}" > "${tmp}" && mv "${tmp}" "${config}"

echo "Set cliPluginsExtraDirs -> ${plugins_dir} in ${config}"
