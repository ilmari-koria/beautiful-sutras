#!/bin/bash
CBETA_ID="$1"
BASEX="./basex/bin/basex"
PUBLISH_DIR="./publish"
BXS="./src/bxs/generate-pdf.bxs"

mkdir $PUBLISH_DIR

$BASEX -bpublish-path=$PUBLISH_DIR \
       -bcbeta-id="$1" \
       -c $BXS

rm $PUBLISH_DIR/*.log $PUBLISH_DIR/*.aux
