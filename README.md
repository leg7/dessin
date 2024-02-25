# Ce qui as ete fait

Tous les composants de l'ast sont faits (jusq'aux fonctions).
Le parser peut generer l'ast completement
l'ast a une methode pour exporter le svg vers stdout.

# Ce qui ne marche pas

Il y a un bug avec la generation de l'ast dans mon parser. Une fois l'entree parsee et l'ast generee
bison appelle les destructeurs des unique_ptr et shared_ptr (parceque ils ne sont plus dans le scope)
ce qui rend l'execution de l'ast impossible.
Donc je n'ai pas plus tester si l'execution de l'ast fonctionne.

# Comment compiler/tester?

pour compiler lancer la commande `make` et pour nettoyer `make clean`.
Pour tester les exemples du pdf sont inclus dans `tests/`.
Vous pouvez par exemple tester l'exemple1 en executant cette commande dans le shell.

`./dessin-cc < tests/exemple1`

l'execution de l'ast et l'export svg sont mis en commentaire dans le main pour le raisons ci-dessus.
