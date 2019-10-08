#! /bin/bash
# SIMPLE BASH SCRIPT TO ASSEMBLE GAMEBOY FILES

function error {
echo "Failed. You can't write code. Give up."
exit
}

if [ -f $1.gb ]
  then
   rm $1.gb
fi

export assemble=1
echo "assembling..."
rgbasm -o$1.obj $1.agb || error
echo linking...
rgblink -o$1.gb $1.obj || error
echo fixing...
rgbfix -v -p0 $1.gb
