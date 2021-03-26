# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2021 

# According to the Zsh Plugin Standard:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}

fpath+="${0:h}/lib"
autoload -Uz local-iterm2-version remote-iterm2-version

# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[ZSH_ITERM2_INTEGRATION_DIR]="${0:h}"

URL="https://iterm2.com/shell_integration/zsh"
FILE="${0:h}/iterm2.zsh"
GREP_STR="ShellIntegrationVersion=*.."

[ -f "${FILE}" ] || wget -O "${FILE}" "${URL}"

LOCALVER="$(local-iterm2-version ${GREP_STR} ${FILE})"
REMOTEVER="$(remote-iterm2-version ${URL} ${GREP_STR})"
(( "$REMOTEVER" > "$LOCALVER" )) && wget -O "${FILE}" "${URL}"

chmod +x "${FILE}" && source "${FILE}"

# Use alternate vim marks [[[ and ]]] as the original ones can
# confuse nested substitutions, e.g.: ${${${VAR}}}

# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
