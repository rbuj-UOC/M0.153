#!/usr/bin/env bash

# Other possible shebangs:
##!/bin/bash
##!/opt/homebrew/bin/bash
##!/usr/local/bin/bash

LABS=("LAB1" "LAB2" "LAB3" "LAB4" "LAB5" "LAB6")

usage() {
    echo "Usage: $0 [--pdf] [--html]"
    echo "  --pdf    Generate only PDF report"
    echo "  --html   Generate only HTML report"
}

render_report() {
    local dir="$1"
    local format="$2"
    echo "Generating $format report for $dir..."
    cd "$dir" || exit
    Rscript -e "rmarkdown::render('Exercicis.Rmd', output_format = '${format}_document')"
    # if the previous command failed, exit with error
    if [ $? -ne 0 ]; then
        exit 1
    fi
    # if the previous command succeeded and the format is HTML, zip the HTML
    # file if ZIP_HTML is true
    if [ "$format" = "html" ] && [ "$ZIP_HTML" = true ]; then
        zip Exercicis.html.zip Exercicis.html
    fi
    cd ..
}

# parse command line options
GENERATE_PDF=true
GENERATE_HTML=true
ZIP_HTML=true
while getopts "h-:" opt; do
    case "$opt" in
        -)
            case "${OPTARG}" in
                pdf)
                    GENERATE_HTML=false
                    ;;
                html)
                    GENERATE_PDF=false
                    ;;
                help)
                    usage
                    exit 0
                    ;;
                *)
                    echo "Invalid option: --${OPTARG}"
                    exit 1
                    ;;
            esac
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            echo "Invalid option: -${opt}"
            exit 1
            ;;
    esac
done

if [ "$GENERATE_HTML" = true ]; then
    for dir in "${LABS[@]}"; do
        render_report "$dir" "html"
    done
fi

if [ "$GENERATE_PDF" = true ]; then
    for dir in "${LABS[@]}"; do
        render_report "$dir" "pdf"
    done
fi
