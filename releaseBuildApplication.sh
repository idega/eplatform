#!/bin/sh

echo "[Web Application Release] Is change history (xdoc/changes.xml) commited in? [y/n]"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then

	maven scm:update-project clean test scm:prepare-release
	lastexit="$?"
	#echo exited with $lastexit signal
	if [ $lastexit -eq 0 ]; then
			maven iw-application:deploy site:deploy
	        echo Finished
	else
	        echo Aborted
	fi

fi

