#!/bin/bash

dockercmd="run -ti -v $PWD:/home/project:z quay.io/ctron/rust-esp:latest"

# parse command line arg
case  "$1" in
    create)
        docker $dockercmd create-project
        ;;
    menuconfig)
        docker $dockercmd make menuconfig
        ;;
    build)
        docker $dockercmd build-project
        ;;
    flash)
        esptool write_flash 0x10000 build/esp-app.bin
        ;;
    *)
        printf "usage: $0 (command)\n"
        printf "\tcreate:\t\tcreate new rust project\n"
        printf "\tmenuconfig:\trun esp-idf menuconfig\n"
        printf "\tbuild:\t\tbuild esp-idf, bindings, and rust app\n"
        printf "\tflash:\t\tupload rust app with esptool.py\n"
        ;;
esac
