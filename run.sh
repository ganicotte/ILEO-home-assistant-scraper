#!/bin/bash

# Chemin vers la config générée par Home Assistant
CONFIG_PATH="/data/options.json"

# --- Gestion de la configuration ---
if [ -f "$CONFIG_PATH" ]; then
    echo "🔵 Mode Home Assistant détecté via $CONFIG_PATH"
    
    # Extraction des valeurs JSON vers des variables d'environnement
    export LOGIN=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('ileo_login'))")
    export PASSWORD=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('ileo_password'))")
    export MQTT_HOST=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('mqtt_host'))")
    export MQTT_PORT=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('mqtt_port', 1883))")
    export MQTT_USERNAME=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('mqtt_user'))")
    export MQTT_PASSWORD=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('mqtt_password'))")
    export MQTT_TOPIC_BASE=$(python3 -c "import json; print(json.load(open('$CONFIG_PATH')).get('mqtt_topic'))")
else
    echo "🟠 Mode Docker standard (pas de fichier options.json)."
    echo "   Utilisation des variables d'environnement du système."
fi

echo "🚀 Lancement du scraper..."
python3 app/main.py