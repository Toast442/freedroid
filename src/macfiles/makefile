OBJS=BFont.o SDL_rotozoom.o bullet.o enemy.o graphics.o highscore.o influ.o init.o input.o main.o map.o menu.o misc.o ship.o sound.o takeover.o text.o view.o
HOME=/Users/jasonk
FRAMEWORKS=$(HOME)/projects/root/Library/Frameworks/SDL_2.0
INCPATH=-I ../ -F $(FRAMEWORKS) -I $(FRAMEWORKS)/SDL2.framework/Headers -I $(FRAMEWORKS)/SDL2_image.framework/Headers -I $(FRAMEWORKS)/SDL2_mixer.framework/Headers
GCC=gcc
CFLAGS=-g -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
LDFLAGS=-g -F $(FRAMEWORKS) -framework SDL2 -framework SDL2_image -framework SDL2_mixer -framework Cocoa

all: freedroid

bundle: freedroid
	./macfiles/make-bundle.sh

freedroid: $(OBJS)
	$(GCC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@

.c.o:
	$(GCC) $(CFLAGS) $(INCPATH) -c $<

.m.o:
	$(GCC) $(CFLAGS) $(INCPATH) -c $<

clean:
	rm -f *.o freedroid
	rm -rf ../FreeDroid.app
