#!/bin/bash
# please set path to batik-rasterizer.jar correctly (part of apache batik package)

BATIK="/opt/homebrew/Cellar/batik/1.16/libexec/batik-rasterizer-1.16.jar"

java -jar $BATIK $1 -d $2 -dpi 600
