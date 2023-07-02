<!-- TOC -->

- [Filename](#filename)
- [Pattern Matching](#pattern-matching)
- [Operations on variables](#operations-on-variables)
- [heredoc](#heredoc)

<!-- /TOC -->

# Filename

cmd | result
-- | --
$0 | ./t.sh
$(basename $0)     | t.sh
$(basename $0 .sh) | t
`${PWD##*/}` | parent_dir_name

# Pattern Matching
https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html

# Operations on variables
https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion

type | example | result | More
-- | -- | -- | --
Length | echo ${#SHELL} | 9
`${parameter:-$var}` | `${NULL:-$SHELL}` | /bin/bash 
${parameter:-word} | echo ${SHELL:-ignored} | /bin/bash | [ -z "${COLUMNS:-}" ] && COLUMNS=80 ; echo $COLUMNS
${parameter:=word} | unset a ; echo ${a:=b} ; echo $a | b b
${VAR:OFFSET:KEEP} | echo ${SHELL:0:4} | /bin
${VAR/PATTERN/NEW} | echo ${SHELL/b/}  | /in/bash
${VAR//PATTERN/NEW} | echo ${SHELL//b/} | /in/ash
`${VAR#beginning}` | echo ${SHELL#*/}  | bin/bash
`${VAR##beginning}`| echo ${SHELL##*/} | bash
`${VAR%trailing}`  | ${SHELL%/*h} | /bin

# heredoc
https://en.wikipedia.org/wiki/Here_document#Unix_shells
