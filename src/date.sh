#!/usr/bin/env bash

# @file Date
# @brief Functions for manipulating dates.

# @description Get current time as unix timestamp.
#
# @example
#   date::now
#   #Output
#   1591554426
#
# @noargs
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout Current timestamp.
date::now() {
    local ts
    ts="$(date --universal +%s)" || return
    printf "%s" "$ts"
}

# @description Convert datetime string to unix timestamp.
#
# @example
#   date::epoch "2020-07-07 18:38"
#   #Output
#   1594143480
#
# @arg $1 string Datetime in any format.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout Timestamp for the specified datetime.
date::epoch() {
    (( $# == 0 )) && return 2

    local ts
    ts=$(date -d "$1" +"%s") || return
    printf "%s" "$ts"
}

# @description Add number of days to the specified timestamp.
#
# @example
#   date::add_days_to 1594143480 1
#   #Output
#   1594229880
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of days to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_days_to() {
    (( $# < 2 )) && return 2

    local ts="$1" new_ts days=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $days day" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of months to the specified timestamp.
#
# @example
#   date::add_months_to 1594143480 1
#   #Output
#   1596821880
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of months to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_months_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts months=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $months month" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of years to the specified timestamp.
#
# @example
#   date::add_years_to 1594143480 1
#   #Output
#   1625679480
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of years to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_years_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts years=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $years year" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of weeks to the specified timestamp.
#
# @example
#   date::add_weeks_to 1594143480 1
#   #Output
#   1594748280
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of weeks to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_weeks_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts weeks=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $weeks week" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of hours to the specified timestamp.
#
# @example
#   date::add_hours_to 1594143480 1
#   #Output
#   1594147080
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of hours to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_hours_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts hours=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $hours hour" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of minutes to the specified timestamp.
#
# @example
#   date::add_minutes_to 1594143480 1
#   #Output
#   1594143540
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of minutes to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_minutes_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts minutes=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $minutes minute" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of seconds to the specified timestamp.
#
# @example
#   date::add_seconds_to 1594143480 1
#   #Output
#   1594143481
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of seconds to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::add_seconds_to() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts seconds=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') + $seconds second" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Add number of days to the current (date::now) timestamp.
#
# @example
#   date::add_days_to_now 1
#   #Output
#   1591640826
#
# @arg $1 int Number of days to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_days_to_now() {
    local ts new_ts days=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_days_to "$ts" "$days")" || return
    printf "%s" "$new_ts"
}

# @description Add number of months to the current (date::now) timestamp.
#
# @example
#   date::add_months_to_now 1
#   #Output
#   1594146426
#
# @arg $1 int Number of months to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_months_to_now() {
    local ts new_ts months=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_months_to "$ts" "$months")" || return
    printf "%s" "$new_ts"
}

# @description Add number of years to the current (date::now) timestamp.
#
# @example
#   date::add_years_to_now 1
#   #Output
#   1623090426
#
# @arg $1 int Number of years to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_years_to_now() {
    local ts new_ts years=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_years_to "$ts" "$years")" || return
    printf "%s" "$new_ts"
}

# @description Add number of weeks to the current (date::now) timestamp.
#
# @example
#   date::add_weeks_to_now 1
#   #Output
#   1592159226
#
# @arg $1 int Number of weeks to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_weeks_to_now() {
    local ts new_ts weeks=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_weeks_to "$ts" "$weeks")" || return
    printf "%s" "$new_ts"
}

# @description Add number of hours to the current (date::now) timestamp.
#
# @example
#   date::add_hours_to_now 1
#   #Output
#   1591558026
#
# @arg $1 int Number of hours to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_hours() {
    local ts new_ts hours=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_hours_to "$ts" "$hours")" || return
    printf "%s" "$new_ts"
}

# @description Add number of minutes to the current (date::now) timestamp.
#
# @example
#   date::add_minutes_to_now 1
#   #Output
#   1591554486
#
# @arg $2 int Number of minutes to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_minutes_to_now() {
    local ts new_ts minutes=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_minutes_to "$ts" "$minutes")" || return
    printf "%s" "$new_ts"
}

# @description Add number of seconds to the current (date::now) timestamp.
#
# @example
#   date::add_seconds_to_now 1
#   #Output
#   1591554427
#
# @arg $2 int Number of seconds to add.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::add_seconds_to_now() {
    local ts new_ts seconds=$1
    ts="$(date::now)" || return
    new_ts="$(date::add_seconds_to "$ts" "$seconds")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of days from the specified timestamp.
#
# @example
#   date::sub_days_from 1594143480 1
#   #Output
#   1594057080
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of days to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout timestamp.
date::sub_days_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts days=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $days days ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of months from the specified timestamp.
#
# @example
#   date::sub_months_from 1594143480 1
#   #Output
#   1591551480
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of months to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_months_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts months=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $months months ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of years from the specified timestamp.
#
# @example
#   date::sub_years_from 1594143480 1
#   #Output
#   1562521080
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of years to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_years_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts years=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $years years ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of weeks from the specified timestamp.
#
# @example
#   date::sub_weeks_from 1594143480 1
#   #Output
#   1593538680
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of weeks to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_weeks_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts weeks=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $weeks weeks ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of hours from the specified timestamp.
#
# @example
#   date::sub_hours_from 1594143480 1
#   #Output
#   1594139880
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of hours to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_hours_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts hours=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $hours hours ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of minutes from the specified timestamp.
#
# @example
#   date::sub_minutes_from 1594143480 1
#   #Output
#   1594143420
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of minutes to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_minutes_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts minutes=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T %Z') $minutes minutes ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of seconds from the specified timestamp.
#
# @example
#   date::sub_seconds_from 1594143480 1
#   #Output
#   1594143479
#
# @arg $1 int Unix timestamp.
# @arg $2 int Number of seconds to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
# @exitcode 2 Function missing arguments.
#
# @stdout New timestamp.
date::sub_seconds_from() {
    (( $# == 0 )) && return 2

    local ts="$1" new_ts seconds=$2
    new_ts="$(date -d "$(date -d "@$ts" '+%F %T') $seconds seconds ago" +'%s')" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of days from the current (date::now) timestamp.
#
# @example
#   date::sub_days_from_now 1
#   #Output
#   1588876026
#
# @arg $1 int Number of days to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_days_from_now() {
    local ts new_ts days=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_days_from "$ts" "$days")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of months from the current (date::now) timestamp.
#
# @example
#   date::sub_months_from_now 1
#   #Output
#   1559932026
#
# @arg $1 int Number of months to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_months_from_now() {
    local ts new_ts months=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_months_from "$ts" "$months")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of years from the current (date::now) timestamp.
#
# @example
#   date::sub_years_from_now 1
#   #Output
#   1591468026
#
# @arg $1 int Number of years to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_years_from_now() {
    local ts new_ts years=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_years_from "$ts" "$years")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of weeks from the current (date::now) timestamp.
#
# @example
#   date::sub_weeks_from_now 1
#   #Output
#   1590949626
#
# @arg $1 int Number of weeks to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_weeks_from_now() {
    local ts new_ts weeks=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_weeks_from "$ts" "$weeks")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of hours from the current (date::now) timestamp.
#
# @example
#   date::sub_hours_from_now 1
#   #Output
#   1591550826
#
# @arg $1 int Number of hours to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_hours_from_now() {
    local ts new_ts hours=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_hours_from "$ts" "$hours")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of minutes from the current (date::now) timestamp.
#
# @example
#   date::sub_minutes_from_now 1
#   #Output
#   1591554366
#
# @arg $1 int Number of minutes to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_minutes_from_now() {
    local ts new_ts minutes=$1
    ts="$(date::now)" || return
    new_ts="$(date::sub_minutes_from "$ts" "$minutes")" || return
    printf "%s" "$new_ts"
}

# @description Subtract number of seconds from the current (date::now) timestamp.
#
# @example
#   date::sub_seconds_from_now 1
#   #Output
#   1591554425
#
# @arg $1 int Number of seconds to subtract.
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate timestamp.
#
# @stdout New timestamp.
date::sub_seconds_from_now() {
    local ts new_ts seconds=$1
    ts="$(date::now)"
    new_ts="$(date::sub_seconds_from "$ts" "$seconds")" || return
    printf "%s" "$new_ts"
}

# @description Format unix timestamp to human readable format.
# If the format string is omitted, it defaults to an equivalent of "yyyy-mm-dd hh:mm:ss".
#
# @example
#   date::format 1594143480
#   #Output
#   2020-07-07 18:38:00
#
# @arg $1 int Unix timestamp.
# @arg $2 string Format string based on the `date` command (optional).
#
# @exitcode 0 If successful.
# @exitcode 1 If unable to generate time string.
# @exitcode 2 Function missing arguments.
#
# @stdout Formatted datetime string.
date::format() {
    (( $# == 0 )) && return 2

    local ts="$1" fmt="${2:-"%F %T"}" out
    out="$(date -d "@$ts" +"$fmt")" || return
    printf "%s" "$out"
}
