#!/bin/bash
if ! [ -x "$(command -v dtc)" ]; then
    echo 'Device Tree Compiler not installed.' >&2
    exit 1
fi

if [ $# -eq 0 ]; then
    echo 'No arguments supplied.' >&2
    exit 1
fi

for arg in "$@"
do
    if ! [[ "$arg" == *.dtbo || "$arg" == *.dtb ]]; then
        echo 'Invalid arguments.' >&2
        exit 1
    fi
done

for arg in "$@"
do
    filename="${arg%.*}"
    dtsfile="${filename}.dts"
    dtc -I dtb -O dts -o ${dtsfile} ${arg} 
    cat ${dtsfile}
    rm ${dtsfile}
done