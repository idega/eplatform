#!/bin/sh

echo "[Helper] First step: CVS Update folder to newest in branch? [y/n]"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
cvs update -Pd
fi

echo "[Helper] Next step: Change snapshots in project.xml? (comments out SNAPSHOT version references if any) [y/n]"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
cp project.xml project_helper.xml
sed 's/<version>SNAPSHOT<\/version>/<!--HELPERversion>SNAPSHOT<\/versionHELPER-->/g;s/<!--version>/<!--HELPER--><version>/g;s/<\/version-->/<\/version><!--HELPER-->/g' project_helper.xml > project.xml
rm project_helper.xml
fi

echo "[Helper] Next step: Build War? [y/n]"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
maven clean iw-application:war
fi

echo "[Helper] Next step: Prepare Release? (CVS Tagging) [y/n]"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
maven scm:prepare-release
fi

echo "[Helper] Next step: Deploy built war and site documentation to central repository? [y/n]?"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
maven iw-application:deploy site:deploy
fi


echo "[Helper] Next step: Change back snapshots references in project.xml? (comments in SNAPSHOT) [y/n]?"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
cp project.xml project_helper.xml
sed 's/<!--HELPERversion>SNAPSHOT<\/versionHELPER-->/<version>SNAPSHOT<\/version>/g;s/<!--HELPER--><version>/<!--version>/g;s/<\/version><!--HELPER-->/<\/version-->/g' project_helper.xml > project.xml
rm project_helper.xml
echo "[Helper]...project.xml was modified! Change project.xml. Commit project.xml!"
fi



