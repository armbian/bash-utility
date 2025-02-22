#!/usr/bin/env bash

# @file Array
# @brief Functions for array operations and manipulations.

# @description Check if an item exists in the given array.
#
# @example
#   arr=("a" "b" "c")
#   array::contains "c" "${arr[@]}"" && echo "yes" || echo "no"
#   #Output
#   yes
#
# @arg $1 mixed Item to search (needle).
# @arg $2 array Array to be searched (haystack).
#
# @exitcode 0 If successful.
# @exitcode 1 If no match found in the array.
# @exitcode 2 Function missing arguments.
array::contains() {
    (( $# < 2 )) && return 2

    local needle="${1:-}"
    shift

    local elem
    for elem in "$@"; do
        [[ "$elem" == "$needle" ]] && return 0
    done

    return 1
}

# @description Remove duplicate items from the array.
#
# @example
#   arr=("a" "b" "a" "c")
#   array::dedupe "${arr[@]}"
#   #Output
#   a
#   b
#   c
#
# @arg $1 array Array to be deduped.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Deduplicated array.
array::dedupe() {
    (( $# == 0 )) && return 2

    local -A found
    local -a uniq

    local el
    for el in "$@"; do
        [[ -z "$el" || -n "${found[$el]}" ]] && continue
        uniq+=("$el") && found[$el]=1
    done

    printf "%s\n" "${uniq[@]}"
}

# @description Check if a given array is empty.
#
# @example
#   arr=("a" "b" "c" "d")
#   array::is_empty "${arr[@]}" && echo "yes" || echo "no"
#   #Output
#   no
#
# @arg $1 array Array to be checked.
#
# @exitcode 0 If the given array is empty.
# @exitcode 1 If the given array is not empty.
array::is_empty() {
    local -a arr=("$@")
    (( ${#arr[@]} == 0 )) && return 0 || return 1
}

# @description Join array elements with a string.
#
# @example
#   arr=("a" "b" "c" "d")
#   array::join "," "${arr[@]}"
#   #Output
#   a,b,c,d
#   array::join "" "${arr[@]}"
#   #Output
#   abcd
#
# @arg $1 string String to join the array elements with (glue).
# @arg $2 array Array to be joined with the glue string.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout String containing a string representation of all the array elements in the same order with the glue string between each element.
array::join() {
    (( $# < 2 )) && return 2

    local glue="$1"
    shift

    printf "%s" "$1"
    shift
    printf "%s" "${@/#/$glue}"
    printf "\n"
}

# @description Return an array with elements in reverse order.
#
# @example
#   arr=(1 2 3 4 5)
#   array::reverse "${arr[@]}"
#   #Output
#   5
#   4
#   3
#   2
#   1
#
# @arg $1 array Array to be reversed.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout The reversed array.
array::reverse() {
    (( $# == 0 )) && return 2

    local -a arr=("$@")
    local elem head tail
    for (( head=0, tail=${#arr[@]} - 1; head < tail; head++, tail-- )); do
        elem="${arr[$head]}"
        arr[$head]="${arr[$tail]}"
        arr[$tail]="$elem"
    done

    printf "%s\n" "${arr[@]}"
}

# @description Return a random item from the array.
#
# @example
#   arr=("a" "b" "c" "d")
#   array::random_element "${arr[@]}"
#   #Output
#   c
#
# @arg $1 array Array to pick random items from.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Random item out of the array.
array::random_element() {
    (( $# == 0 )) && return 2

    local -a arr=("$@")
    printf "%s\n" "${arr[RANDOM % $#]}"
}

# @description Sort an array from lowest to highest.
#
# @example
#   arr=("a c" "a" "d" 2 1 "4 5")
#   array::sort "${arr[@]}"
#   #Output
#   1
#   2
#   4 5
#   a
#   a c
#   d
#
# @arg $1 array Array to be sorted.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Sorted array.
array::sort() {
    (( $# == 0 )) && return 2

    local -a arr=("$@") sorted

    local old_state="$(shopt -po noglob)"
    set -o noglob

    local IFS=$'\n'
    sorted=($(sort <<< "${arr[*]}"))
    unset IFS

    eval "$old_state"

    printf "%s\n" "${sorted[@]}"
}

# @description Sort an array in reverse order (highest to lowest).
#
# @example
#   array=("a c" "a" "d" 2 1 "4 5")
#   array::rsort "${array[@]}"
#   #Output
#   d
#   a c
#   a
#   4 5
#   2
#   1
#
# @arg $1 array Array to be sorted.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Reverse-sorted array.
array::rsort() {
    (( $# == 0 )) && return 2

    local -a arr=("$@") sorted

    local old_state="$(shopt -po noglob)"
    set -o noglob

    local IFS=$'\n'
    sorted=($(sort -r <<< "${arr[*]}"))
    unset IFS

    eval "$old_state"

    printf "%s\n" "${sorted[@]}"
}

# @description Bubble sort an integer array from lowest to highest.
# This sort does not work on string arrays.
#
# @example
#   arr=(4 5 1 3)
#   array::bsort "${arr[@]}"
#   #Output
#   1
#   3
#   4
#   5
#
# @arg $1 array Array to be sorted.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Bubble-sorted array.
array::bsort() {
    (( $# == 0 )) && return 2

    local -a arr=("$@")

    local elem i j
    for (( i = 0; i <= ${#arr[@]} - 2; ++i )); do
        for (( j = i + 1; j <= ${#arr[@]} - 1; ++j )); do
            if (( arr[i] > arr[j] )); then
                elem=${arr[i]}
                arr[i]=${arr[j]}
                arr[j]=$elem
            fi
        done
    done

    printf "%s\n" "${arr[@]}"
}

# @description Merge two arrays.
# Pass variable names of the arrays instead of their values.
#
# @example
#   a=("a" "c")
#   b=("d" "c")
#   array::merge "a[@]" "b[@]"
#   #Output
#   a
#   c
#   d
#   c
#
# @arg $1 string Variable name of the first array.
# @arg $2 string Variable name of the second array.
#
# @exitcode 0 If successful.
# @exitcode 2 Function missing arguments.
#
# @stdout Merged arrays.
array::merge() {
    (( $# != 2 )) && return 2

    local -a arr1=("${!1}") arr2=("${!2}")
    local out=("${arr1[@]}" "${arr2[@]}")

    printf "%s\n" "${out[@]}"
}
