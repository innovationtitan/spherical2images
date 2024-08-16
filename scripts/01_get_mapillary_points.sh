#!/usr/bin/env bash
mkdir -p data

################ Download points and sequences ################
mapimg="docker run -v $PWD:/mnt/ -e MAPILLARY_ACCESS_TOKEN=$MAPILLARY_ACCESS_TOKEN -it developmentseed/spherical2images:v1"

$mapimg get_mapillary_points \
    --output_file_point=data/denver_points.geojson \
    --output_file_sequence=data/data/denver_sequences.geojson \
    --bbox=-105.109,39.614,-104.60,39.9142

aws s3 sync data/ s3://wastebin/v0.1/mapillary/points_sequences/
