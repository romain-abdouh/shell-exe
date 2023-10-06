utilisateur="romain"
cd /home/romain/shell.exe/JOB08
nombre_connexions=$(sudo journalctl -b | grep "session opened for user $utilisateur" | wc -l)
date_actuelle=$(date +"%d-%m-%Y-%H:%M")
echo "Nombre de connexions de l'utilisateur $utilisateur : $nombre_connexions" > number_connection-$date_actuelle
if [ ! -d Backup ]; then
  mkdir -p Backup
fi
fichier_a_archiver=number_connection-$date_actuelle
archive_sortie="archive.tar"
tar -cf "$archive_sortie" "$fichier_a_archiver"
mv $archive_sortie number_connection-$date_actuelle.tar
mv number_connection-$date_actuelle.tar Backup/
