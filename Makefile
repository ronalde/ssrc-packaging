CC = gcc
CFLAGS = -O2 -lm 
#CFLAGS += -DBIGENDIAN

all : ssrc ssrc_hp

ssrc : ssrc.c fftsg_ld.c dbesi0.c
	$(CC) $(CFLAGS) ssrc.c fftsg_ld.c dbesi0.c -o ssrc

ssrc_hp : ssrc.c fftsg_ld.c dbesi0.c
	$(CC) $(CFLAGS) -DHIGHPREC ssrc.c fftsg_ld.c dbesi0.c -o ssrc_hp

clean :
	rm -f ssrc ssrc_hp *.o *~