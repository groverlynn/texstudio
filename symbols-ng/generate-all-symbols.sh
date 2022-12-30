#!/bin/bash
# provide the path to the gesym-ng binary as first argument

#GESYMBNG=$1
GESYMBNG="../gesymb-ng.app/Contents/MacOS/gesymb-ng"
BATIK="/Users/Grover/Documents/GitHub/groverlynn/texstudio/symbols-ng/batikConvert.sh"
SYMBOLS_all="arrows cyrillic delimiters greek misc-math misc-text operators relation special wasysym icons fontawesome5"
#SYMBOLS="arrows cyrillic delimiters greek misc-math misc-text operators relation special wasysym icons fontawesome5"
SYMBOLS="delimiters misc-math misc-text operators relation wasysym"

echo "Deleting old files..."

for i in $SYMBOLS; do

	if [ -d $i ]; then
		cd $i
		rm -f *
		cd ..
	fi

done

for i in $SYMBOLS; do

	echo "Generating image files in $i..."
	mkdir -p generate

	if [ ! -d $i ]; then
		mkdir $i
	fi
	cd generate
	rm -f *
	$GESYMBNG ../$i.xml $BATIK &> log.txt

	# for j in *.svg; do
	# 	f=${j%.svg}
	# 	if [ ! -e $f.png ]; then
	# 		java -jar /opt/homebrew/Cellar/batik/1.16/libexec/batik-rasterizer-1.16.jar $f.svg -d $f.png -dpi 600
	# 	fi
	# done

	mv *.svg ../$i
	mv *.png ../$i
	cd ..

done

#generate symbols.qrc
echo "Generate symbols.qrc"
rm ../symbols.qrc
echo "<RCC>">../symbols.qrc
echo "<qresource prefix=\"/\">">>../symbols.qrc
for i in $SYMBOLS_all; do
	ls -1 $i|xargs -I {} echo "<file>"symbols-ng/$i/{}"</file>" >> ../symbols.qrc
done
echo "</qresource>">>../symbols.qrc
echo "</RCC>">>../symbols.qrc
