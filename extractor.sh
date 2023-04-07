#!/usr/bin/env bash

mntDir="mntdir"
outDir="outdir"

function log() {
    local msg="$1"
    printf '%s\n' "${msg}"
}

function loadPlugins {
    log "* load plugins start" debug
    for load in $(find "bin/" -name '*.sh'); do
        . "${load}"
        log "loaded ${load}" "debug"
    done
    log "* load plugins done" debug
}


function showHelp() {
    printf 'extractor v0.0.7 - cannot be used on computers'
    printf 'Usage: extractor.sh [switches] [input path] [output path]\n'
    printf '%s \n' "--outdir -o path where is image file stored"
    printf '%s \n' "--extract <image name> <outputdir> extract files from single image"
    printf '%s \n' "--all process all images is possible (littlebit faulty, overwrite target)"
    printf '%s \n' "--magic magically fix device if some fails"
    return 0
}

function magic() {
    dir_name="$(pwd)";
    for mnt in $(mount | grep "$(pwd)" | awk '{print $3}'); do
        echo "umounting: ${mnt}"
        umount -f "${mnt}"
    done

    for loop in $(losetup | grep "${dir_name}" | awk '{print $1}'); do
        echo "destroy loop ${loop}"
        losetup -D "${loop}"
    done
}

function extractAllImages() {
    mkdir -p "${mntDir}"
#    rm -rf $outDir/*
    mkdir -p "${outDir}"
    find "diskety/" -name '*.img' -print0 | while IFS= read -r -d $'\0' image; do
        extractImage "${image}" "${outdir}"
    done
}

loadPlugins

while [[ $# -gt 0 ]]; do
  case "$1" in
    --outdir|-o)
        outdir="$2"
        shift
        shift
        ;;
    --help|-h)
        showHelp
        exit 0
        shift
        ;;
    --all)
        #experimental :D
        extractAllImages
        shift
        exit 0
        ;;
    --extract)
        #<image name> <outputdir>
        if [[ -z "$2" ]]; then
            shift
            extractImage "$1" "${outDir}"
            
        else
            shift
            extractImage "$1" "$2"
            shift
            shift
        fi
        
        ;;
    --magic)
        magic
        shift
        ;;
    *)
        printf 'invalid option %s\n' "$@"
        showHelp
        exit 0
  esac
done

