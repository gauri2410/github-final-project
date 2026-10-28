#!/usr/bin/env bash

set -eu
export LC_NUMERIC=C

is_non_negative_number() {
    [[ $1 =~ ^([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]
}

read -r -p "Principal: " principal
if ! is_non_negative_number "$principal" || ! awk -v value="$principal" 'BEGIN { exit !(value > 0) }'; then
    printf 'Error: principal must be a positive number.\n' >&2
    exit 1
fi

read -r -p "Annual interest rate (%): " rate
if ! is_non_negative_number "$rate"; then
    printf 'Error: rate must be a non-negative number.\n' >&2
    exit 1
fi

read -r -p "Time (years): " time
if ! is_non_negative_number "$time"; then
    printf 'Error: time must be a non-negative number.\n' >&2
    exit 1
fi

awk -v principal="$principal" -v rate="$rate" -v time="$time" 'BEGIN {
    interest = principal * rate * time / 100
    printf "Simple interest: %.2f\n", interest
    printf "Total amount: %.2f\n", principal + interest
}'
