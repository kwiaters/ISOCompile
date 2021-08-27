#!/bin/bash
clear
CHOICE=4
LIST=$(ls /mnt/backup)

	echo "LISTA DOSTEPNYCH KATALOGOW: \n\n$LIST\n"
	echo "Podaj nazwe katalogu: \c \n "
		read DATAKATALOG

	echo "\n Podaj katalog do kompilacji: \n 1. Praca \n 2. Sieci gazowe \n 3. Przylacza gazowe \n :\c"

	while [ $CHOICE -eq 4 ]; do
	  read CHOICE
	  if [ $CHOICE -eq 1 ] ; then
		KATALOG="praca"
	  else
	  if [ $CHOICE -eq 2 ] ; then
		KATALOG="Sieci_Gazowe"
	  else
	  if [ $CHOICE -eq 3 ] ; then
		KATALOG="Przylacza_Gazowe"
	else 
		echo "\n Wybierz opcje 1-3 \n"
		CHOICE=4
	  fi
	fi
	fi
done

	echo "\n Podaj wielkosc kompilacji w MB (zalecana dla plyt DVD to 4300): \c \n"
	  read SIZE

	echo "\n Za 5 sekund rozpocznie sie tworzenie listy plikow do nagrania \n"
	sleep 5
dirsplit -s ${SIZE}MB -e2 /mnt/backup/$DATAKATALOG/data/$KATALOG

COUNTFILES=$(ls -l vol_*.list | grep -c vol_)
	echo "\n Za chwile nastapi kompilacja $COUNTFILES obrazow plyty\n"
	sleep 5
i=1
while [ $i -le $COUNTFILES ]
do
	mkisofs -r -joliet-long -graft-points -o ${KATALOG}_${i}.iso -path-list vol_$i.list
		echo "\n Utworzono $i z $COUNTFILES obrazow... POZOSTALO $((COUNTFILES-$i)) \n"
		sleep 5
	i=$((i+1))
done
	rm -rf vol_*.list

	echo "Utworzono $COUNTFILES plikow ${KATALOG}.iso "