
# 1. Jeu 2D développé via Godot

Créé et développé par Jerry Cleuet
 - [1. Jeu 2D développé via Godot](#1-jeu-2d-développé-via-godot)

# 2. Documentation de la mise en place et de l'apprentissage
## 2.1. Lancement du projet
 Pour commencer, d'où m'est venue l'idée de créer un jeu 2D en utilisant Godot ? Bonjour, je m'appelle Jerry Cleuet, et au travers de cette documentation, je vais vous transmettre mes motivations, mes méthodes et ce que j'ai appris lors de ce projet. Pour naviguer entre les différents chapitres plus rapidement, il existe une table des matières juste au dessus de ce texte ↑.

 Coder un jeu vidéo, c'est le rêve de la plupart des jeunes qui s'inscrivent en informatique après leur cursus scolaire obligatoire. C'est d'ailleurs pour cette raison que je me suis moi-même dirigé vers ce domaine en CFC après mes années de VP. Mais alors, pourquoi Godot ?

 J'ai choisi Godot comme moteur de jeu pour une raison très simple : je me suis renseigné et ai pu découvrir que c'était une des solutions les plus simples et intuitives pour développer un jeu vidéo sans avoir beaucoup de connaissances dans le domaine. Ne connaissant rien au game dev, je suis allé chercher de l'inspiration sur YouTube car on y trouve des vidéos très détaillées et reconnues sur le sujet.

 Pour apprendre les bases des contrôles et des scripts, j'ai regardé [cette vidéo](https://www.youtube.com/watch?v=LOhfqjmasi0) en même temps que je reproduisais ce que je voyais. C'est ainsi que j'ai fait mes débuts en game dev sur Godot.

 ## Apprentissage
 ### Scènes
 ---
 Les scènes sont des arbres de nodes, des éléments que l'on va vouloir réutiliser dans notre jeu. On crée une scène par exemple pour le joueur, les ennemis, les pièces, les plateformes... Tout objet que l'on veut pouvoir réutiliser dans notre jeu doit être fait sous forme de scène.

 Quand on crée une scène, il y a un grand nombre de possibilités d'ajout pour créer l'élément souhaité : que ce soit en 2D ou en 3D on peut ajouter des hitbox, des sons, des animations, des caméras pour suivre un personnage, des timers, des rayons de détection... 
 ### Assets
 ---
 Les assets sont les images que l'on va utiliser dans le jeu. Pour un jeu 2d, les assets peuvent être plus ou moins pixelisés selon le rendu que l'on veut donner. Dans mon cas, j'ai utilisé des assets de base libres de droit ; mais il m'est également arrivé de créer des assets originaux ! Pour faire cela, il m'a juste fallu un site pour faire du pixel art, un peu d'imagination et hop ! ça permet de créer facilement des sprites personnalisés adaptés au style du jeu.
 ### Scripts
 ---
 Les scripts comportent toute la partie logique du jeu. Bien que l'on puisse définir énormément de choses via l'interface graphique de Godot, on est tout de même obligé de passer par cette étape, plus ou moins réjouissante. Pour ma part, je préfère largement la création de niveaux et d'assets, qui utilisent l'imagination et la créativité, au codage de scripts qui est plus logique et compliqué au début.

 Dans les scripts, on définit des conditions, des boucles et des fonctions comme dans tout langage de programmation. Changements d'animations, réaction aux collisions, contrôles via souris/clavier... On peut à peu près tout gérer à partir des scripts.
 ### Signaux
 ---
 Sur Godot, les signaux font "partie" du code. Dans l'interface, on retrouve différents types de signaux que l'on peut utiliser dans le code : signaux de collision, de canvas, d'objet ou de node. En fait, ces signaux sont émis quand il y a un changement ; si la souris passe sur quelque chose, si on touche un ennemi... Ils servent à alléger la charge de code à produire. Un signal est un évènement, et on peut le connecter à une fonction pour y réagir.

 ### Tilemap et Tileset
 ---
 Tilemap et Tileset : deux choses presque nécessaires au bon développement du jeu, puisque ce sont ces deux éléments qui gèrent le rendu du background et des éléments visibles en premier plan. Pour les définir/utiliser, il faut un fichier comprenant les éléments que l'on veut utiliser pour l'interface de notre jeu, comme des blocs, des arbres, du terrain etc. Dans le tileset, on sélectionne sur le fichier (généralement un png) les éléments que l'on pourra ajouter au jeu avec le tilemap.

 Avec le tilemap, il est également possible de créer plusieurs plans séparés, par exemple : le premier plan qui serait la partie active du jeu, comprenant les collisions entre entité et blocs et le second plan qui serait juste le décor du jeu.

 ### Bonnes pratiques
 ---
Pour développer avec Godot, il y a des bons gestes à appliquer pour rendre le projet plus lisible et maintenable. 
- Construire une arborescence cohérente entre scripts, scènes et assets
- Toujours renommer les scènes avec des noms cohérents
- Nommer les variables et constantes 
- Commenter un minimum le code implémenté dans les scripts
- Rendre le code dans les scripts le plus réutilisable possible

## Déroulement de mon projet
### Limites et fonctionnalités
---
La première chose à faire avant de démarrer un projet de développement, c'est de définir les fonctionnalités à implémenter, les limites du projet et la cible du produit final.
#### Fonctionnalités
---
Pour mon jeu, je veux au minimum implémenter les fonctionnalités suivantes :
- On doit pouvoir contrôler le joueur pour se déplacer et sauter
- On doit pouvoir mourir de dégâts de chute ou des ennemis
- Les ennemis doivent être en mouvement
- Le joueur doit pouvoir obtenir des objets
- Le joueur doit pouvoir tuer un ennemi avec un certain objet
- Le joueur doit pouvoir récupérer des pièces
- Le compteur de pièces doit s'afficher sur l'écran et au-dessus du joueur au moment du ramassage
- Il doit y avoir des plateformes traversables par en-dessous
- Il doit y avoir des plateformes en mouvement
- Il doit y avoir des plateformes piégées
- Il doit y avoir des PNJ avec des boîtes à dialogue interactives
- Il doit y avoir des parcours cachés durant les niveaux, durs à trouver mais à fortes récompenses
- Quand on meurt, on doit revenir au début du jeu automatiquement
- Quand on meurt, il y a une mini animation avec le joueur qui tombe au ralenti

Une fois terminées, je pourrai me concentrer sur les fonctionnalités suivantes (bonus):
- Il doit y avoir un menu quand on lance le jeu
- Il doit y avoir une musique de fond adaptées
- Il doit y avoir une animation de mort des ennemis
- Il doit y avoir une animation quand le joueur prend un objet
- Il doit y avoir un son quand le joueur prend un objet
- Il doit y avoir un son quand un ennemi ou le joueur meurt
- Le joueur doit avoir des vies, qu'il pourra augmenter au cours des niveaux et qui devront être sauvegardées de façon permanente
- Le jeu doit avoir un systèmes de sauvegardes pour que le joueur ne perde pas sa progression
- Il doit y avoir un background sur plusieurs plans, assez réfléchi et joli
- Il doit y avoir des villages interactifs dans le background avec des maisons à visiter
- Il doit y avoir des énigmes pour progresser utilisant la mécanique des pnjs et des maisons/villages
#### Limites
---
Mon jeu n'est pas prévu pour un grand public mais plus comme projet d'apprentissage, les limites seront donc vite atteintes : pas besoin de 3D, d'assets monstrueux ou de mécaniques compliquées.
- Pas de physique réaliste poussée
- Pas d'IA complexe dans le jeu
- Pas de multijoueur
#### Cible
---
Comme dit précédemment, mon jeu n'est pas conçu dans un cadre de vente ou de mise en production à grande échelle. La cible principale est donc moi-même, les cibles secondaires sont les personnes de l'entourage proche qui feront office de testeurs.

## Difficultés rencontrées
---
Lors de ce projet, il m'est arrivé bien des fois d'arriver à cours d'inspiration, d'idées ou juste de me retrouver bloqué par mon manque de connaissances dans le game dev.
- Création d'assets : sans expérience dans le domaine, il m'est arrivé de ne pas être satisfait du rendu de ce que je produisais
- Scripts : il m'est arrivé de me retrouver bloquer