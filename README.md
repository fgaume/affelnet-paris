# Exposition des données Affelnet

Ce projet expose sous forme de fichiers statiques (.json) les données nécessaires à l'application Affelnet-app

## Les données exposées à l'application

### Les paramètres de l'application

Dans app.json se trouvent :
* La version courante de l'application : cela permet à un client navigateur de déterminer son éventuel retard et donc de solliciter une mise à jour auprès de l'utilisateur
* seuils_editables : si à true, alors l'application offre la possibilité à l'utilisateur de saisir des seuils d'admission (période Affelnet actif)
* stats_editables : si à true, alors l'application offre la possibilité à l'utilisateur de saisir des stats (période Affelnet actif). La période d'activité peut est plus courte que celle des seuils, d'où la nécessité de 2 paramètres différents
* bonus_exceptionnel : si à true, le bonus exceptionnel est activé (désactivé tant que la règle reste floue)

### Données des collèges

Le fichier colleges.json expose la liste des collèges et leur données associées : nom, bonus IPS, nb d'admis au DNB (utilisé pour peser le nombre de collégiens en concurrence sur un lycée).

### Données des lycées

Le fichier lycees.json expose la liste des lycées, avec en particulier leur historique de seuils d'admission

### Statistiques des champs disciplinaires

Le fichier statistiques.json expose l'historique des moyennes et ecarts-types des champs disciplinaires

### Les nouveaux seuils en cours de validation

Le fichier seuils_recents consolident les nouveaux seuils récemment saisie par les parents dans l'app.
Les seuils saisis ne sont pas directement enregistrés et présentés dans l'app. Ils sont validés avant.

### Les nouvelles stats de champs disciplinaires

Même principe : les nnouvelles stats sont exposées ici à l'app.

## Les données publiques

Il s'agit des données exposées pubiquement, non utilisées par l'application.

## Informations développeur

Pour tester en local, démarrer un serveur http comme suit :

```
http-server --cors='*' -p 8080 public
```


