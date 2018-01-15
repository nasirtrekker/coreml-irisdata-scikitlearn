# -*- coding: utf-8 -*-
"""
# Nasir Uddin
# this file convert coreML model

"""

from sklearn import datasets
from sklearn.linear_model import LogisticRegression
from sklearn.externals import joblib

import coremltools

# Load the dataset: Iris (flower types)
iris = datasets.load_iris()
# training model: (with logistic regression)
model = LogisticRegression()
model.fit(iris.data, iris.target)

# make a prediction
print'prediction with the scilit iris model'
#sepal lenths, sepal width, petal length, petal width
print iris.target_names[model.predict([ [1.0,2.0,2.0,3.0]])]
joblib.dump(model, 'iris.pkl')

# exporting(saving) to core ML format
#parameters: model, feature names(virginica, setosa, ....)
coreml_model = coremltools.converters.sklearn.convert(model, iris.feature_names, 'iris class')
coreml_model.save('iris.mlmodel')