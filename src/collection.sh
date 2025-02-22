#!/usr/bin/env bash

# @file Collection
# @brief (Experimental) Functions to iterate over a list of elements, yielding each in turn to a predicate function.

# @description Iterate over elements of a collection and invoke predicate function for each one.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   test_func() {
#       printf "print value: %s\n" "$1"
#   }
#   arr=("a b" "c d" "a" "d")
#   printf "%s\n" "${arr[@]}" | collection::each test_func
#   # alternate version
#   collection::each test_func  < <(printf "%s\n" "${arr[@]}")
#   #Output
#   print value: a b
#   print value: c d
#   print value: a
#   print value: d
#
# @example
#   arr=("a" "a b" "c d" "a" "d")
#   out=("$(array::dedupe "${arr[@]}")")
#   collection::each test_func  <<< "${out[@]}"
#   #Output
#   print value: a
#   print value: a b
#   print value: c d
#   print value: d
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
# @exitcode ? Exit code returned by the predicate.
#
# @stdout Output of the predicate function.
collection::each() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi || return
    done
}

# @description Check if the predicate returns true for all elements of the collection. Iteration is stopped once the predicate returns false.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   arr=("1" "2" "3" "4")
#   printf "%s\n" "${arr[@]}" | collection::every "variable::is_numeric"
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If the predicate was true for every element.
# @exitcode 1 Otherwise.
# @exitcode 2 Function missing arguments.
collection::every() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi || return 1
    done
}

# @description Iterate over elements of a collection, returning all elements for which the predicate is true.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   arr=("1" "2" "3" "a")
#   printf "%s\n" "${arr[@]}" | collection::filter "variable::is_numeric"
#   #Output
#   1
#   2
#   3
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout array Values for which the predicate is true.
collection::filter() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi && printf "%s\n" "$it"
    done
}

# @description Iterate over elements of a collection, returning the first element for which the predicate is true.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   arr=("1" "2" "a" "3")
#   is_a() {
#       [[ "$1" == "a" ]]
#   }
#   printf "%s\n" "${arr[@]}" | collection::find "is_a"
#   # alternate version
#   collection::find '[[ $it == "a" ]]' < <(printf "%s\n" "${arr[@]}")
#   #Output
#   a
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If an element satisfying the predicate was found.
# @exitcode 1 Otherwise.
# @exitcode 2 Function missing arguments.
#
# @stdout First element satisfying the predicate.
collection::find() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi && {
            printf "%s\n" "$it"
            return 0
        }
    done
    return 1
}

# @description Invoke function with the elements passed as arguments to it.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   opt=("-a" "-l")
#   printf "%s\n" "${opt[@]}" | collection::invoke "ls"
#
# @arg $1 string Name of function to invoke.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
# @exitcode ? Exit code returned by the function.
#
# @stdout Output from the function.
collection::invoke() {
    (( $# == 0 )) && return 2

    local fn="$1"

    local -a args=()
    while read -r it; do
        args=("${args[@]}" "$it");
    done

    eval "$fn" "${args[@]}"
}

# @description Apply predicate function to each element of a collection and return the results.
# Input to the function can be a pipe output, here-string or file.
#
# @example
#   arr=(1 2 3)
#   add_one() {
#       printf "%s\n" "$(( $1 + 1 ))"
#   }
#   printf "%s\n" "${arr[@]}" | collection::map "add_one"
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
# @exitcode ? Exit code returned by the function.
#
# @stdout Output of the predicate function for each element.
collection::map() {
    (( $# == 0 )) && return 2

    local it out pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            out="$("$pred")"
        else
            out="$("$pred" "$it")"
        fi || return

        printf "%s\n" "$out"
    done
}

# @description The opposite of the filter function; return all elements for which the predicate is false.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   arr=("1" "2" "3" "a")
#   printf "%s\n" "${arr[@]}" | collection::reject "variable::is_numeric"
#   #Output
#   a
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout array Values for which the predicate is false.
# @see collection::filter
collection::reject() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi || printf "%s\n" "$it"
    done
}

# @description Check if the predicate returns true for at least one element of the collection.
# Input to the function can be pipe output, here-string or a file.
#
# @example
#   arr=("a" "b" "3" "c")
#   printf "%s\n" "${arr[@]}" | collection::some "variable::is_numeric"
#
# @arg $1 string Name of the predicate function.
#
# @exitcode 0 If the predicate was true for at least one element.
# @exitcode 1 Otherwise.
# @exitcode 2 Function missing arguments.
collection::some() {
    (( $# == 0 )) && return 2

    local it pred="$1" IFS=$'\n'
    while read -r it; do
        if [[ "$pred" == *"$"* ]]; then
            eval "$pred"
        else
            eval "$pred" "'$it'"
        fi && return
    done

    return 1
}
