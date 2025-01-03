import requests
import json
import subprocess

def get_last_value(code):
  """
  Effectue l'appel à l'API et extrait la dernière valeur de "serie1-1".
  """
  url = f"https://data.education.gouv.fr/api/records/1.0/analyze/?disjunctive.rentree_scolaire=true&disjunctive.region_academique=true&disjunctive.academie=true&disjunctive.departement=true&disjunctive.commune=true&disjunctive.numero_lycee=true&disjunctive.denomination_principale=true&disjunctive.patronyme=true&disjunctive.secteur=true&refine.numero_lycee={code}&dataset=fr-en-lycee_gt-effectifs-niveau-sexe-lv&x=rentree_scolaire&sort=&maxpoints=50&y.serie1-1.expr=2ndes_gt&y.serie1-1.func=SUM&y.serie1-1.cumulative=false&timezone=Europe%2FBerlin&lang=fr"  # Remplacez par votre URL
  response = requests.get(url)
  
  print("res=" + response.text)
  response.raise_for_status()  # Lève une exception en cas d'erreur HTTP

  # Utilise jq pour extraire la valeur
  jq_command = "jq '.[-1].\"serie1-1\"'"
  result = subprocess.run(["jq", jq_command], input=response.text, capture_output=True, text=True)
  
  print("result=" + result.stdout)
  return result.stdout.strip()

def process_json(data):
  """
  Traite la liste d'objets JSON et ajoute le champ "last_value".
  """
  for obj in data:
    code = obj["code"]
    last_value = get_last_value(code)
    obj["effectif"] = last_value
  return data

# Charger le fichier JSON
with open("lycees_seuils.json", "r") as f:
  data = json.load(f)

test = get_last_value("0750680G")
print("val="+test)
# Traiter les données
# processed_data = process_json(data)

# Enregistrer le résultat dans un nouveau fichier
#with open("output.json", "w") as f:
#  json.dump(processed_data, f, indent=2)