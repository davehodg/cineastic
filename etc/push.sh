#!/bin/sh

(
   cd ../..
   dotcloud push movies movies-on-dotcloud/
)


DBIC_TRACE=1 plackup -r --port 5001

