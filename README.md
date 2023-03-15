# Test technique iOS PSA (Stellantis): Application météo

Test technique officiel de Stellantis (PSA), réalisé par Koussaïla BEN MAMAR, le 15/03/2022

## Table des matières
- [Objectifs](#objectif)
    + [Réalisation d’une application Météo](#sujet)
    + [Instructions](#instructions)
    + [Contexte technique](#contexte)
    + [Contraintes](#contrainte)
- [Ma solution](#solution)
- [Guide d'utilisation de l'app](#userguide)

## <a name="objectif"></a>Objectifs

Pour ce test technique, le délai est de 6 jours à compter de la réception du test.

### <a name="sujet"></a>Réalisation d’une application Météo

Votre mission si vous l’acceptez sera de réaliser une application Météo.

#### L’application sera décomposée en 2 modules:

**Une partie Composant (Framework):**
- Récupère les informations météo depuis une API 

**Une partie UI (Application):**
- Affiche les informations provenant du composant.

**L’application sera composée de 3 écrans:**
- Une liste affichant la liste des villes ajoutées par utilisateur
- Une vue pour ajouter une ville
- Une vue détail affichant les différentes informations météo
d’une ville

**Optionnellement vous pouvez:**
- Persister les données afin de pouvoir utiliser l’application offline
- Ajouter des Tests Unitaires pour votre Composant
- Ajouter des diagrammes de séquence pour votre
Composant
- Ajouter une documentation pour l’utilisation de votre
Composant

### <a name="instructions"></a>Instructions

L’application devra être déposée sur un repository Git public

Ce qui sera observé:
- La qualité du code
- L’architecture, les patterns utilisés
- La pertinence des commits
- Les optimisations diverses

Vous êtes libre de choisir le design qui vous paraît le plus pertinent.

### <a name="contexte"></a>Contexte technique

#### API

Utilisez l’API suivante pour les informations météo: https://openweathermap.org/api/one-call-api

L’utilisation de cette API nécessite une inscription.

### <a name="contrainte"></a>Contraintes

- Swift
- SDK Min 11 (iOS 13, 14 au minimum est toléré).
- L’utilisation des librairies externes à Apple est proscrite.

## <a name="solution"></a>Ma solution

Pour ce test technique de haut niveau, j'ai mis en place une **Clean Architecture**:
- **Pour la partie data:** Un framework externe `MeteoWeatherData` contenant les méthodes pour récupérer les informations météo depuis l'API et pour la persistance des données locales avec Core Data. Un repository pour l'interface entre la partie app et data.
- **Pour la partie app:** J'ai mis en place la variante **VIP (View Interactor Presenter** du template **Clean Swift** de Raymond LAW pour la Clean Architecture.

### Frameworks particuliers utilisés

- UIKit
- Combine (Programmation réactive fonctionnelle)
- Core Data (persistance des données)
- XCTest (tests unitaires)

L'utilisation de frameworks externes à Apple est interdite (RxSwift, Alamofire, Kingfisher,...) dans ce test.

La documentation est disponible pour le framework.

### Tests unitaires implémentés:
- Framework: Service réseau, service local
- App: Presenters liste et ajout.

## Difficultés

**Du fait que ce test soit très long et très complexe pour un délai court de 6 jours, par manque de temps**:
- Je n'ai pas pu aller jusqu'au bout pour écrire l'ensemble des tests unitaires pour le framework, il me manque la partie repository. L'approche TDD (Test Driven Development) me demanderait 2 à 3 fois plus de temps pour la mettre en place.
- Faire le diagramme de séquence.

**Au niveau technique**:
- L'API n'est pas adaptée pour mettre à jour directement l'ensemble de la liste. Il faudrait chaîner les requêtes puis la sauvegarde, engendrant ainsi des problèmes de synchronisation (allant au deadlock) et de la corruption de données. De plus, l'utilisation de l'API est très limitée, 60 requêtes/minute.

## <a name="userguide"></a>Guide d'utilisation de l'app

L'application se compose en 3 écrans.

### Écran liste

Cet écran récupère les données sauvegardées dans la base de données locale et affiche une liste de villes avec leurs données météo respectives, s'il y a des données en base.

Tapez sur une cellule de la liste pour afficher l'écran avec les détails.

Pour ajouter la météo d'une ville, tapez sur le bouton + .

![ListScreen](ListScreen.png)

### Écran ajout

C'est ici que vous pouvez ajouter une nouvelle ville avec ses données météo. Tapez un lieu dans la barre de recherche, et l'application téléchargera et afficher en auto-complétion une liste de suggestions. Sélectionnez la ville parmi les suggestions de votre recherche et l'écran ajout se fermera pour revenir à l'écran de la liste. 

Une fois la ville sélectionnée, l'application téléchargera les données de météo et les sauvegardera dans la base de données locale. L'écran principal actualisera automatiquement la liste avec la nouvelle ville ajoutée. Notez que si vous recherchez une ville qui est déjà sauvegardée, ses données seront mises à jour.

![AddScreen](AddScreen.png)

### Écran détail

C'est ici que vous pouvez consulter l'ensemble des données météo à l'heure actuelle avec les détails:
- Température: actuelle, ressentie, minimum, maximum
- Vent: vitesse et rafale
- Heure du lever et du coucher du soleil
- Pression atmosphérique
- Humidité
- Visibilité
- Pluie / Neige si disponible

![DetailScreen](DetailScreen.png)