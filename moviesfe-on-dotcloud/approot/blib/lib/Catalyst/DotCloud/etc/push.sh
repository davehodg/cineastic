#!/bin/sh

set +e 


cp config.yaml.live                            config.yaml
cp ../approot-be/config.yml.live ../approot-be/config.yml

(
   cd ..
   dotcloud push cineastic
)
cp               config.yaml.local              config.yaml
cp ../approot-be/config.yml.local ../approot-be/config.yml

