# -*- coding: utf-8 -*-
"""Untitled43.ipynb

Généré automatiquement par Colab.

Le fichier original se trouve à :
    https://colab.research.google.com/drive/1C-yZ05KIOr3WghXLEd0Pe_FDfVP7yLQK
"""

import os # chemins vers les fichiers
import numpy as np # algèbre linéaire
import pandas as pd # traitement des données
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression

# Lecture du fichier CSV en tant que DataFrame
tr_df = pd.read_csv('C:\Users\Alaa\Desktop\gomy\train.csv')
# Exploration des 5 premières lignes
tr_df.head()

# Lecture du fichier CSV en tant que DataFrame
te_df = pd.read_csv('C:\Users\Alaa\Desktop\gomy\test.csv')
# Exploration des 5 premières lignes
te_df.head()

# Informations sur les colonnes
tr_df.info(verbose=True)

# Statistiques descriptives
tr_df.describe()

# La colonne Id n'est pas nécessaire, on la supprime dans les jeux de données d'entraînement et de test
tr_df.drop('Loan_ID', axis=1, inplace=True)
te_df.drop('Loan_ID', axis=1, inplace=True)
# Vérification des nouvelles dimensions
print(f"jeu d'entraînement (lignes, colonnes) : {tr_df.shape}\n\njeu de test (lignes, colonnes) : {te_df.shape}")

# Valeurs manquantes en ordre décroissant
tr_df.isnull().sum().sort_values(ascending=False)

# Remplissage des données manquantes
print("Avant de remplir les valeurs manquantes\n\n", "#"*50, "\n")
null_cols = ['Credit_History', 'Self_Employed', 'LoanAmount', 'Dependents', 'Loan_Amount_Term', 'Gender', 'Married']

for col in null_cols:
    print(f"{col}:\n{tr_df[col].value_counts()}\n", "-"*50)
    tr_df[col] = tr_df[col].fillna(
    tr_df[col].dropna().mode().values[0] )

# Vérification des valeurs manquantes après remplissage
tr_df.isnull().sum().sort_values(ascending=False)
print("Après avoir rempli les valeurs manquantes\n\n", "#"*50, "\n")
for col in null_cols:
    print(f"\n{col}:\n{tr_df[col].value_counts()}\n", "-"*50)

# Liste de toutes les colonnes
# Cols = tr_df.tolist()
# Liste de toutes les colonnes numériques
num = tr_df.select_dtypes('number').columns.to_list()
# Liste de toutes les colonnes catégorielles
cat = tr_df.select_dtypes('object').columns.to_list()

# DataFrame des colonnes numériques
loan_num = tr_df[num]
# DataFrame des colonnes catégorielles
loan_cat = tr_df[cat]

# Suppression des lignes contenant des valeurs manquantes
tr_df = tr_df.dropna()
te_df = te_df.dropna()

# Remplacement des valeurs '3+' par 3 et conversion en float pour les dépendants
tr_df['Dependents'] = tr_df['Dependents'].replace('3+', 3).astype(float)
te_df['Dependents'] = te_df['Dependents'].replace('3+', 3).astype(float)

# Valeurs uniques dans les colonnes spécifiques
tr_df["Gender"].unique()
tr_df["Married"].unique()
tr_df["Education"].unique()
tr_df["Property_Area"].unique()
tr_df["Loan_Status"].unique()

from sklearn.preprocessing import LabelEncoder

# Utilisation de LabelEncoder pour encoder les variables catégorielles
le = LabelEncoder()

# Liste des colonnes catégorielles à encoder
categorical_cols = tr_df.select_dtypes(include=['object']).columns.to_list()

# Application de LabelEncoder à chaque colonne catégorielle dans les jeux de données d'entraînement et de test
for col in categorical_cols:
    tr_df[col] = le.fit_transform(tr_df[col])

# Vérification des valeurs uniques après encodage
tr_df["Gender"].unique()
tr_df["Married"].unique()
tr_df["Education"].unique()
tr_df["Property_Area"].unique()
tr_df["Loan_Status"].unique()

# Séparation des caractéristiques et de la cible
y = tr_df['Loan_Status']
X = tr_df.drop('Loan_Status', axis=1)

# Séparation des données en ensembles d'entraînement et de test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)

# Initialisation et entraînement du modèle de régression logistique
LR = LogisticRegression()
LR.fit(X_train, y_train)

# Prédictions sur les données de test
y_predict = LR.predict(X_test)

# Résumé des prédictions
print(classification_report(y_test, y_predict))

# Score de précision
LR_SC = accuracy_score(y_predict, y_test)
print('La précision est', accuracy_score(y_predict, y_test))

# Sauvegarde du modèle entraîné dans un fichier pickle
import pickle
with open('logistic_regression_model.pkl', 'wb') as file:
    pickle.dump(LR, file)
