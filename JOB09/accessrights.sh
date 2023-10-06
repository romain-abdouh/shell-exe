sed '1d' Shell_Userlist.csv > temp_file.csv


while IFS=',' read -r id prenom nom mot_de_passe role; do
	role=${role:0:(${#role}-1)} 
	nom_utilisateur=$(echo "$prenom $nom")

  if [ -d "/home/$nom_utilisateur" ]; then
	if [ "$role" = "Admin" ]; then
	sudo usermod -aG sudo "$nom_utilisateur"
	else
	sudo usermod -G users "$nom_utilisateur"
	fi
    echo "L'utilisateur $nom_utilisateur existe déjà. Ignoré."
  else
   sudo useradd "$nom_utilisateur" --badname --uid "$id" --create-home
   echo "$nom_utilisateur:$mdp" | sudo chpasswd
	if [ "$role" = "Admin" ]; then
	sudo usermod -aG sudo "$nom_utilisateur"
   	fi
  fi
done < temp_file.csv

rm temp_file.csv
echo "Toutes les opérations sont terminées."
