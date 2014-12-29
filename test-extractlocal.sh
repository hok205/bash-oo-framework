#!/bin/bash

shopt -s expand_aliases

oo:assignParamsToLocal() {
    ## unset first miss
    unset __oo__params[0]
    declare -i i
    local iparam
    local variable
    local type
    for i in "${!__oo__params[@]}"
    do
        echo "i    : $i"

        iparam=$i

        variable="${__oo__params[$i]}"
        echo "var  : ${__oo__params[$i]}"

        i+=-1
        type="${__oo__param_types[$i]}"
        echo "type : ${__oo__param_types[$i]}"

        ### TODO: check if type is correct

#        eval "$variable=\"${!iparam}\""
        eval "$variable=\"\$$iparam\""
    done
}

alias oo:stashPreviousLocal="declare -a \"__oo__params+=( \$(declare -p | grep 'declare -- ' | tail -1 | cut -d ' ' -f 3) )\""
alias @var="oo:stashPreviousLocal; declare -a \"__oo__param_types+=( TYPE )\"; local "
alias @@verify="oo:stashPreviousLocal; oo:assignParamsToLocal"

bambo() {
    @var test1
    @var test2
    @@verify "$@"

    echo here is first: "$test1"
    echo here is 2nd: "$test2"
}

bambo "value of one" valueOf2
