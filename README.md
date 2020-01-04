This is a gameboy game that I am making (attempting to make at least) so I can learn more about assembly / low level programming. This mostly started because I originally wanted to make a Nintendo DS game, but didn't want to have to do that much art and didn't really understand how embedded programming worked.

The easiest way to get set up is with VSCode and the Extension rgbds-vscode (https://github.com/DonaldHays/rgbds-vscode). This extension will show documentation for all the instructions for the GB's processor, cycles per instruction, and will let you look up documentation for your created symbols. It is super useful.

To compile, you need RGBDS (https://github.com/rednex/rgbds). It is kind of a pain to get set up on windows, I found the easiest way to set up a windows dev environment is to use the built in ubuntu shell, its way less annoying than using cygwin or minGW. 
You need to install GCC, yacc, libpng and pkg-config to run. for ubuntu, it should just be `sudo apt-get install gcc byacc flex pkg-config libpng-dev`. Then you go into the RDBS directory and run `make`, then `make install`

I am probably a bit over aggressive with my documentation in my source code, a lot of comments are a bit verbose and repetitive, its more me working through understanding my code and z80 assembly than something I would have in a production environment.