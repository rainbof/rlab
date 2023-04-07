#!/usr/bin/env bash

function extractAllImages() {
    mkdir -p "${mntDir}"
    mkdir -p "${outDir}"

    for image in $(find "diskety/" -name '*.img'); do
        extractImage "${image}" "${outdir}"
        magic
    done
}