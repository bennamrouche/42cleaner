#!/bin/bash

clear 

read -r -d '' ASCII_ART << "EOF"
_________________               _________________
 ~-.              \  |\___/|  /              .-~
     ~-.           \ / o o \ /           .-~
        >           \\  W  //           <
       /             /~---~\             \
      /_  ALPHABEN  |       | 42 Cleaner  _\
         ~-.        |       |        .-~
            ;        \     /        i
           /___      /\   /\      ___\
                ~-. /  \_/  \ .-~
                   V         V
EOF


echo -e "\033[33m $ASCII_ART"

echo -e "42 Session Clean \n"


before=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')

if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi


# exit 
should_log=0
if [[ "$1" == "-p" || "$1" == "--print" ]]; then
	should_log=1
fi

function delete  {

	if [ -z "$1" ]; 
	then 
		return 0 
	fi

	/bin/rm -rf "$@" &>/dev/null   &   
	sleep 0.05 
	return 0
}

function clean {

	shopt -s nullglob

	echo -ne "\033[38;5;208m"

	#42 Caches
	delete  "$HOME"/Library/*.42*

echo -ne "|███ 10%|\r"

	delete  "$HOME"/*.42*
	delete  "$HOME"/.zcompdump*
	delete  "$HOME"/.cocoapods.42_cache_bak*
	delete  /Library/Caches/*
	delete  /System/Library/Caches/*
	delete  ~/Library/Caches/*	
echo -ne "|██████ 20%|\r"

	delete  "$HOME"/.Trash/*
	/bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
	delete  "$HOME"/Library/Caches/*
	delete  /private/var/folders/bh/*/*/*/*
	delete  /Library/Logs/DiagnosticReports/*
	delete  /Library/Logs/CreativeCloud/*
	delete  /Library/Logs/Adobe/*
	delete  /Library/Logs/adobegc.log
	delete  ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*
	delete  ~/Library/Logs/CoreSimulator/*
	delete  ~/Library/Developer/Xcode/DerivedData/*
	delete  ~/Library/Developer/Xcode/Archives/*
	delete  ~/Library/Developer/Xcode/iOS Device Logs/*

echo -ne "|███████ 30%|\r"
	delete  "$HOME"/Library/Application\ Support/Caches/*
	delete  "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
	delete  "$HOME"/Library/Application\ Support/Slack/Cache/*
	delete  ~/Library/Application\ Support/Steam/appcache
	delete  ~/Library/Application\ Support/Steam/depotcache
	delete  ~/Library/Application\ Support/Steam/logs
	delete  ~/Library/Application\ Support/Steam/steamapps/shadercache
	delete  ~/Library/Application\ Support/Steam/steamapps/temp
	delete  ~/Library/Application\ Support/Steam/steamapps/download
	delete  ~/.android/cache
	delete  ~/.gradle/caches
echo -ne "|██████████ 40%|\r"

	delete  "$HOME"/Library/Application\ Support/discord/Cache/*
	delete  "$HOME"/Library/Application\ Support/discord/Code\ Cache/js*
	delete  "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*
	delete  ~/Library/Application\ Support/Microsoft/Teams/IndexedDB
	delete  ~/Library/Application\ Support/Microsoft/Teams/Cache
	delete  ~/Library/Application\ Support/Microsoft/Teams/Application\ Cache
	delete  ~/Library/Application\ Support/Microsoft/Teams/Code\ Cache
	delete  ~/Library/Application\ Support/Microsoft/Teams/blob_storage

echo -ne "|███████████████ 50%|\r"

	delete  "$HOME"/Library/Application\ Support/Code/Cache/*
	delete  "$HOME"/Library/Application\ Support/Code/CachedData/*
	delete  "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*

echo -ne "|███████████████████ 60%|\r"

	delete  "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*

echo -ne "|██████████████████████ 70%|\r"

	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/*
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/*
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/*
	delete  ~/Library/Application\ Support/Microsoft/Teams/databases
	delete  ~/Library/Application\ Support/Microsoft/Teams/gpucache
	delete  ~/Library/Application\ Support/Microsoft/Teams/Local\ Storage

echo -ne "|█████████████████████████ 80%|\r"

	delete  "$HOME"/Desktop/**/*/.DS_Store
	delete  ~/Library/Application\ Support/Microsoft/Teams/tmp
	delete  ~/Library/Application\ Support/Microsoft/Teams/*logs*.txt
	delete  ~/Library/Application\ Support/Microsoft/Teams/watchdog
	delete  "$HOME"/Library/Application\ Support/Chromium/Default/File\ System

echo -ne "|█████████████████████████████ 90%|\r"

	delete  "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
	delete  "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System
	delete  ~/Library/Application\ Support/Microsoft/Teams/*watchdog*.json
 	delete  "$HOME"/Desktop/Piscine\ Rules\ *.mp4
	delete  "$HOME"/Desktop/PLAY_ME.webloc
	npm cache clean --force &>/dev/null

echo -ne "|████████████████████████████████████ 100%|"
echo -ne "\033[0m\n\n"

}

clean


if [ $should_log -eq 1 ]; then
	echo
fi


after=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')

if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi

if [ "$before" !=   "$after" ];
 then
	echo -e "\033[33m ---█████████[+] Storage  \033[0;31m  $before \033[33m  to \033[0;32m  $after \033[33m [+]█████████---\033[0m\n"
	exit
fi

	echo -e "\033[33m ---█████████[+]\033[0;31m    No Data to Clean    ): \033[33m \033[33m  [+]█████████---\033[0m\n"