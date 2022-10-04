#!/bin/bash

set -e

check_dependencies() {
    export ENV_DEPENDENCIES="helm"

    for app_dep in $(echo $ENV_DEPENDENCIES); do
        if ! [ -x "$(command -v $app_dep)" ]; then
            echo ""
            echo "$app_dep could not be found! Please install it!"
            echo ""

            printf "%s " "Press enter to continue"
            read ans

            exit 1
        fi
    done
}

setup_environment() {
    export REPO_DIR=$(git rev-parse --show-toplevel)
}

install() {
    # Install Istio
    helm repo add istio https://istio-release.storage.googleapis.com/charts

    helm dependency build ./istio-base/
    helm dependency build ./istiod/
    helm dependency build ./istio-gateway-ingress/

    helm install --atomic --create-namespace istio-system --namespace istio-system -f ./istio-base/values.yaml ./istio-base/
    helm install --atomic --namespace istio-system --name-template user-aaa -f ./istiod/values.yaml ./istiod/
    helm install --atomic --namespace istio-ingress --name-template user-aaa -f ./istio-gateway-ingress/values.yaml ./istio-gateway-ingress/
}

show_help() {
    echo "Yo!"
}

check_dependencies

if [ $# -eq 0 ]; then
    show_help
else
    case $1 in
    install)
        install
        break
        ;;

    *)
        echo "unknown cli arguments: $@"
        break
        ;;
    esac
fi
