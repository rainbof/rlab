#!/usr/bin/env bash

debug=false
mntDir="mntdir"
outDir="outdir"

function log() {
    local msg="$1"
    printf '%s\n' "$msg"
}

function loadPlugins {
    log "* load plugins start" debug
    for load in $(find "bin/" -name '*.sh'); do
        . $load
        log "loaded ${load}" "debug"
    done
    log "* load plugins done" debug
}

function showHelp() {
    printf 'extractor v0.0.7 - cannot be used on computers'
    printf 'Usage: extractor.sh [switches] [inut path] [output path]\n'
    printf '%s \n' "--dirname -d path where is image file stored"
    printf '%s \n' "--extract <image name> <outputdir> extract files from single image"
    printf '%s \n' "--all process all images is possible (littlebit faulty, overwrite target)"
    printf '%s \n' "--magic magically fix device"
    return 0
}


function extractAllImages() {
    mkdir -r $mntDir
#    rm -rf $outDir/*
    mkdir -r $outDir

    for image in $(find "diskety/" -name '*.img'); do
        extractImage "${image}" "${outdir}"
    done
}

loadPlugins

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dirname|-d)
        dirname="$2"
        shift
        shift
        ;;
    --help|-h)
        showHelp
        exit 0
        shift
        ;;
    --run)
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
    *)
        printf 'invalid option %s\n' "$@"
        showHelp
        exit 0
  esac
done

