#!/usr/bin/env bash

if [[ -f /etc/bootstrap.stamp ]]; then
	printf "Already bootstrapped\n"
	return
fi

SYSNAME=$((uname -s))
SYSVERS=$((uname -r))

ANSIBLE_NAME=(
	[Ubuntu]=ansible
	[Darwin]=ansible
)

PYTHON_NAME=(
	[Ubuntu]=python
	[Darwin]=python3
)

function brew_install() {
	for name in "$@"; do
		brew install "$name"
	done
}

function apt_get_install() {
	for name in "$@"; do
		apt-get install "$name"
	done
}

function yum_install() {
	for name in "$@"; do
		yum install "$name"
	done
}

if [[ -f /etc/os-release ]]; then
	source /etc/*release
fi

python_version=$((python -V))
if [[ $? -ne 0 ]]; then
	printf "Please install python 3"
fi
# Ask to run brew on Darwin, apt / yum on others.

touch /etc/bootstrap.mark
