#!/bin/bash

if [ "$1" == "setup" ]; then
    if [ ! -f ../.env.development ]; then
        cp ../.env.example ../.env.development
        echo "Copied .env.example to .env.development"
        . ./fetchSecretsLocally.sh
    else
        echo ".env.development already exists. No action taken."
    fi;
fi;

if [ "$1" == "update" ]; then
    if [ -f ../.env.development ]; then
        rm ../.env.development
    fi;
    cp ../.env.example ../.env.development
    echo "Copied .env.example to .env.development"
    . ./fetchSecretsLocally.sh
fi;

if [ "$1" == "remove" ]; then
    if [ -f ../.env.development ]; then
        rm ../.env.development
        echo "Removed .env.development"
    else
        echo ".env.development does not exist. No action taken."
    fi;
fi;