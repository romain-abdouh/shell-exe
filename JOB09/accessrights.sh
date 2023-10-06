#!/bin/bash
sed '1d' Shell_Userlist.csv > temp_file.csv
while IFS=',' read -r id prenom nom mdp role; do 
    nom_utilisateur="${prenom} ${nom}"

    if id "$nom_utilisateur" &>/dev/null; then
        if [ "$role" = "Admin" ]; then
            sudo usermod -aG sudo "$nom_utilisateur"
        else
            sudo usermod -G users "$nom_utilisateur"
        fi
        echo "L'utilisateur $nom_utilisateur existe déjà. Ignoré."
    else
        sudo useradd -m -c "$role" -s /bin/bash -p  "$mdp" -u "$id" "$nom_utilisateur" --badname
        if [ "$role" = "Admin" ]; then
            sudo usermod -aG sudo "$nom_utilisateur"
        fi
    fi
done < temp_file.csv

rm temp_file.csv
echo "Toutes les opérations sont terminées."
