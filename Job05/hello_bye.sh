message="$1"
if [ "$message" = "Hello" ]; then
echo "Bonjour, je suis un script !"
elif [ "$message" = "Bye" ]; then
echo "Au revoir et bonne journée!"
else
echo "Message non valide, écrivez 'Hello' ou 'Bye'"
fi
