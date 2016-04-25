#!/usr/bin/env bash

if which pygmentize >/dev/null 2>&1; then
FILTER="pygmentize -f terminal -l diff"
else
FILTER="cat"
fi

rpmdiff() {
set -e
local pkg="$1"
# check whether pkg is installed
rpm -q "${pkg}" || return 1;

# get informations of packages
local pkg="$(rpm -q --queryformat="%{name}" ${pkg})"
local full_pkg="$(rpm -q "${pkg}" 2>/dev/null)"

# fetch rpm
local rpm_path="$(find /var/cache/yum -iname "${full_pkg}.rpm")"
if [ ! -f "${rpm_path}" ]; then
	sudo yum reinstall -y --downloadonly "${full_pkg}"
	rpm_path="$(find /var/cache/yum -iname "${full_pkg}.rpm")"
fi

# make diff
mkdir -p patches
sudo rpm -V ""${pkg} | sed 's/.........\s*c\s*//p;d' | while read -d $'\n' file; do
	rpm2cpio "${rpm_path}" | cpio --quiet -i -E <(echo ".${file}") --to-stdout | sudo diff -u --label "${file}" - "${file}";
done | tee patches/${pkg}.patch | ${FILTER}
}

for p in "${@}"; do
rpmdiff "$p"
done
