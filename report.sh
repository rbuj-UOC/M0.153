#!/usr/bin/env bash

LABS=("LAB1" "LAB2" "LAB3" "LAB4" "LAB5" "LAB6")
ZIP_HTML=true

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

for dir in "${LABS[@]}"; do
    render_report "$dir" "html"
done
