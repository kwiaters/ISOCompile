#!/bin/bash
IP="172.22.1.101:554" 		#adres IP i port rtsp
USER="guest"			#nazwa uzytkownia
PASS="Guest" 		#haslo
DURATION="1200"			#dlugosc nagrania w sekundach
CODEC="-4" 			#kodek dla mpeg4
SIZE="-w 1280 -h 720" 		#rozmiar obrazu w pikselach w=szerokosc h=wyskosc
FRAMES="15" 			#liczba klatek na sekude
DIR="/mnt/cams/cam1"		#katalog gdzie zapisywane sa nagrania
BUFFER="-b 700000"		#bufor dla pliku (domyslnie jest 100000 czyli 100kByte)

GRAB_CAM1() {
openRTSP -u $USER $PASS $BUFFER -d $DURATION $CODEC $SIZE -f $FRAMES rtsp://$IP/snl/live/1/1 > $DIR/cam1.temp
}

while true
do
NOW=$(date +"%Y-%m-%d_%H.%M.%S")
GRAB_CAM1
mv $DIR/cam1.temp $DIR/cam1_$NOW.avi
done
