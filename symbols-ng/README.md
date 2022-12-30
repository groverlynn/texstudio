Symbol generation code was copied and adapted from kile.
Use batik toolkit (apache) for svg to png conversion

# Build the binary gesymb-ng with Qt5:
```
qmake symbols-ng.pro
make all
```

# Set path for 
* `BATIK` jar in `batikConvert.sh` 
* `BATIK` bash in `generate-all-symbols.sh`
* `gesymb-ng` binary in `generate-all-symbols.sh`

# Run the bash file to generate
```
bash generate-all-symbols.sh
```
