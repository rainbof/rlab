#!/usr/bin/env bash

function extractAllImages() {
    mkdir -r $mntDir
    mkdir -r $outDir

    for image in $(find "diskety/" -name '*.img'); do
        extractImage "${image}" "${outdir}"
        magic
    done
}