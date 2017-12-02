# Random Forest Regression

# Importing the libraries
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cross_validation import train_test_split
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, r2_score
import statsmodels.formula.api as sm

# Importing the dataset
dataset = pd.read_csv('yelp_reviews_min.csv')
numberOfFeatures = 12

X = dataset.iloc[:, 1:8].values
y = dataset.iloc[:, numberOfFeatures].values.reshape(-1, 1)

#Feature Scaling
X_scaler = StandardScaler().fit(X)
X_scaled = X_scaler.transform(X)

# Splitting the dataset into the Training set and Test set
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size = 0.5, random_state = 0)

#Fitting Random Forest Regression to the dataset
randomforest = RandomForestClassifier(n_estimators = 21, random_state = 0)
randomforest.fit(X_train, y_train)

# Predicting on the test set 
y_pred = randomforest.predict(X_test)
regressionRes = y_pred.reshape(-1,1)

# performance metrics
accuracy = accuracy_score(regressionRes, y_test)
print(accuracy)
