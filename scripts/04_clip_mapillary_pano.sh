#!/usr/bin/env bash
# outputDir=data
# mkdir -p $outputDir
mapimg="docker run -v $PWD:/mnt/ -e MAPILLARY_ACCESS_TOKEN=$MAPILLARY_ACCESS_TOKEN -it developmentseed/spherical2images:v1"

################ Download points and sequences ################
neighborhoods="denver"
for neighborhood in $neighborhoods; do
    echo "NEIGHBORHOOD: $neighborhood"
    # mkdir -p $outputDir/$neighborhood
    $mapimg clip_mapillary_pano \
        --input_file_points=s3://urban-blight/detroit/mapillary/points_sequences/${neighborhood}_simplify_validated.geojson \
        --image_clip_size=1024 \
        --output_file_points=s3://urban-blight/detroit/mapillary/points_sequences/${neighborhood}_point_images.geojson \
        --output_images_path=s3://urban-blight-public-mapillary-images/detroit/mapillary/images/$neighborhood \
        --cube_sides=right,left,front,back
done
