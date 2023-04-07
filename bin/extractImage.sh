#!/usr/bin/env bash

function extractImage {
    image="$1"
    outdir="$2"

    extract_path="${outDir}/$(basename "${image}")"
    if [[  -s "${image}" ]]; then
        dev="$(losetup -f)"
        log "processing ${image}" "debug"
        losetup "${dev}" "${image}"
        mount "${dev}" "${mntDir}"
        if ! [[ -d "${extract_path}" ]]; then
            mkdir "${extract_path}"
        fi
        cp -r ${mntDir}/* "${extract_path}"
        sync
        umount "${mntDir}"
        losetup -D "${dev}"
    else
        printf 'File %s is zero-size. sorry bro\n' "${image}"
    fi
}
