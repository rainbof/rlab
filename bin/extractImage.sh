#!/usr/bin/env bash

function extractImage {
    image="$1"
    outdir="$2"
    if [[  -s "${image}" ]]; then
        dev="$(losetup -f)"
        log "processing ${image}" "debug"
        losetup "${dev}" "${image}"
        mount "${dev}" "${mntDir}"
        mkdir "${outDir}/$(basename ${image})"
        cp -r ${mntDir}/* "${outDir}"/"$(basename ${image})"
        sync
        umount "${mntDir}"
        losetup -D "${dev}"
    else
        printf 'File %s is zero-size. sorry bro\n' "${image}"
    fi
}
