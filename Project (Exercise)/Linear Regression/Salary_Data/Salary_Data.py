#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt


# In[5]:


data = pd.read_csv("Salary_Data.csv")
data.head()


# In[6]:


data.info()


# In[7]:


data.describe().T


# In[9]:


#Plots help to explain the values and how they are scattered

plt.figure(figsize=(12,6))
sns.pairplot(data,x_vars=["YearsExperience"],y_vars=["Salary"],size=7,kind="scatter")
plt.xlabel("Years")
plt.ylabel("Salary")
plt.title("Salary Prediction")
plt.show()


# In[10]:


X = data["YearsExperience"]
X.head()


# In[11]:


y = data["Salary"]
y.head()


# In[13]:


from sklearn.model_selection import train_test_split


# In[14]:


# Split the data for train and test

X_train,X_test,y_train,y_test = train_test_split(X,y,train_size=0.7,random_state=100)


# In[15]:


# Create new axis for x column

X_train = X_train[:,np.newaxis]
X_test = X_test[:,np.newaxis]


# In[16]:


from sklearn.linear_model import LinearRegression


# In[17]:


# Fitting the model

lr = LinearRegression()
lr.fit(X_train,y_train)


# In[18]:


# Predicting the Salary for the Test values

y_pred = lr.predict(X_test)


# In[21]:


# Plotting the actual and predicted values

c = [i for i in range (1,len(y_test)+1,1)]
plt.plot(c,y_test,color='r',linestyle='-')
plt.plot(c,y_pred,color='b',linestyle='-')
plt.xlabel('index')
plt.ylabel('Salary')
plt.title('Prediction')
plt.show()


# In[22]:


# plotting the error
c = [i for i in range(1,len(y_test)+1,1)]
plt.plot(c,y_test-y_pred,color='green',linestyle='-')
plt.xlabel('index')
plt.ylabel('Error')
plt.title('Error Value')
plt.show()


# In[23]:


# Importing metrics for the evaluation of the model

from sklearn.metrics import r2_score,mean_squared_error


# In[24]:


# calculate Mean square error

mse = mean_squared_error(y_test,y_pred)


# In[25]:


# Calculate R square vale

rsq = r2_score(y_test,y_pred)


# In[26]:


print('mean squared error :',mse)
print('r square :',rsq)


# In[27]:


# Just plot actual and predicted values for more insights
plt.figure(figsize=(12,6))
plt.scatter(y_test,y_pred,color='r',linestyle='-')
plt.show()


# In[28]:


# Intecept and coeff of the line
print('Intercept of the model:',lr.intercept_)
print('Coefficient of the line:',lr.coef_)


# In[29]:


#  y = 25202.8 + 9731.2x

