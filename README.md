# 🛳️ Prédiction de Survie du Titanic – Déploiement d’un Modèle ML avec FastAPI & Docker

## 1. Problème de Machine Learning

L’objectif de ce projet est de prédire si un passager du Titanic a survécu ou non en fonction de ses caractéristiques personnelles et de voyage.  
Il s’agit d’un **problème de classification binaire**, où :

- `Survived = 1` → le passager a survécu  
- `Survived = 0` → le passager n’a pas survécu  

Le dataset (Kaggle) contient des données variées :

- **Numériques** : Age, Fare  
- **Catégorielles** : Sex, Embarked  
- **Ordinales** : Pclass  
- **Familiales** : SibSp, Parch  

Le défi consiste à gérer les valeurs manquantes, encoder les variables catégorielles et construire un modèle robuste.

---

## 2. Étapes clés de la méthodologie

### **1. Chargement et exploration des données**
- Importation du dataset Titanic  
- Analyse des colonnes et distributions  
- Identification des valeurs manquantes (Age, Cabin, Embarked)  
- Analyse des corrélations avec la variable cible  

### **2. Nettoyage des données**
- Imputation des valeurs manquantes (Age, Embarked)  
- Suppression des colonnes trop incomplètes (Cabin, Ticket)  
- Normalisation optionnelle des variables numériques  

### **3. Encodage des variables catégorielles**
- Encodage binaire pour `Sex`  
- One‑Hot Encoding pour `Embarked`  

### **4. Séparation des données**
- Division en train/test  
- Définition des features et de la target (`Survived`)  

### **5. Entraînement du modèle – RandomForestClassifier**
- Choix des hyperparamètres (n_estimators, max_depth, etc.)  
- Entraînement sur les données prétraitées  
- Évaluation : accuracy, matrice de confusion, classification report  

### **6. Sérialisation du modèle**
- Sauvegarde du modèle avec `joblib`  

### **7. Intégration dans l’API FastAPI**
- Chargement du modèle dans l’API  
- Création de l’endpoint `/predict`  
- Validation des entrées utilisateur  

### **8. Conteneurisation avec Docker**
- Construction d’une image reproductible  
- Exécution de l’API dans un environnement isolé  

---

## 3. Stack utilisé & justification des choix

### **Python**
Langage principal du projet, idéal pour :
- le développement du modèle
- la manipulation des données
- la création de l’API 
- l’intégration avec des librairies comme scikit‑learn, pandas ou joblib  

---

### **FastAPI**
Framework web moderne, rapide et très adapté au déploiement de modèles ML :
- validation automatique des données via Pydantic  
- documentation interactive générée automatiquement (Swagger UI)  
- performance élevée grâce à Starlette et ASGI  
- syntaxe simple et propre  

---

### **Docker**
Utilisé pour conteneuriser l’application :
- garantit la **reproductibilité** de l’environnement  
- facilite le **déploiement** sur n’importe quelle machine  
- isole les dépendances
- permet d’exécuter l’API de manière stable et portable  

---

### **Jupyter Notebook**
Outil utilisé pour :
- explorer les données
- tester différentes approches
- entraîner et évaluer le modèle
- documenter les étapes d’analyse

---

### **GitHub**
Plateforme utilisée pour :
- versionner le code  
- collaborer  
- stocker le projet  
- suivre l’évolution du développement  

---

## 4. Lancer l’application

### **Prérequis**
- Docker installé  
- Make

---
```bash
    make help
    
    make: build and launch the services
    make shell: enter in the shell of the app container
    make cp: Copy the notebook and the model from the container to the local directory
    make ps: Show all the services launched
    make clear: down and clean the containers
```