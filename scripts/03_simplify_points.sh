#!/usr/bin/env bash
outputDir=data
mkdir -p $outputDir

mapimg="docker run -v $PWD:/mnt/ -e MAPILLARY_ACCESS_TOKEN=$MAPILLARY_ACCESS_TOKEN -it developmentseed/spherical2images:v1"

aws s3 sync s3://urban-blight/detroit/mapillary/points_sequences/ $outputDir/

$mapimg simplify_points \
    --input_points=$outputDir/denver_points_filter.geojson \
    --output_points=$outputDir/denver_simplify.geojson

aws s3 sync $outputDir/ s3://urban-blight/detroit/mapillary/points_sequences/
