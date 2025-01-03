#!/bin/bash

# code='0750680G'
# url="https://data.education.gouv.fr/api/records/1.0/analyze/?disjunctive.rentree_scolaire=true&disjunctive.region_academique=true&disjunctive.academie=true&disjunctive.departement=true&disjunctive.commune=true&disjunctive.numero_lycee=true&disjunctive.denomination_principale=true&disjunctive.patronyme=true&disjunctive.secteur=true&refine.numero_lycee=${code}&dataset=fr-en-lycee_gt-effectifs-niveau-sexe-lv&x=rentree_scolaire&sort=&maxpoints=50&y.serie1-1.expr=2ndes_gt&y.serie1-1.func=SUM&y.serie1-1.cumulative=false&timezone=Europe%2FBerlin&lang=fr"  # Remplacez par votre URL

# curl -s $url | jq '.[-1]."serie1-1"'

# last_value=$(curl -s $url | jq '.[-1]."serie1-1"')

# echo $last_value

# exit(0)

jq -c '.[]' lycees_seuils.json | \
while read obj; do
  code=$(echo "$obj" | jq -r '.code')
  url="https://data.education.gouv.fr/api/records/1.0/analyze/?disjunctive.rentree_scolaire=true&disjunctive.region_academique=true&disjunctive.academie=true&disjunctive.departement=true&disjunctive.commune=true&disjunctive.numero_lycee=true&disjunctive.denomination_principale=true&disjunctive.patronyme=true&disjunctive.secteur=true&refine.numero_lycee=${code}&dataset=fr-en-lycee_gt-effectifs-niveau-sexe-lv&x=rentree_scolaire&sort=&maxpoints=50&y.serie1-1.expr=2ndes_gt&y.serie1-1.func=SUM&y.serie1-1.cumulative=false&timezone=Europe%2FBerlin&lang=fr"  # Remplacez par votre URL
  last_value=$(curl -s $url | jq '.[-1]."serie1-1"')
  echo "$obj" | jq --arg last_value "$last_value" '. + {capacite: $last_value}'
done | jq -s '.' > output.json 