#!/usr/bin/env python
# coding: utf-8

# In[1]:


import warnings
warnings.filterwarnings('ignore')

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


# In[2]:


# 1) Reading and Understanding the Data


# In[6]:


cars = pd.read_csv('CarPrice_Assignment.csv')
cars.head()


# In[7]:


cars.shape


# In[8]:


cars.describe().T


# In[9]:


cars.info()


# In[10]:


# 2) Data Cleaning and Preparation


# In[11]:


#Splitting company name from CarName column
CompanyName = cars['CarName'].apply(lambda x : x.split(' ')[0])
cars.insert(3,"CompanyName",CompanyName)
cars.drop(['CarName'],axis=1,inplace=True)
cars.head()


# In[12]:


cars.CompanyName.unique()


# In[13]:


# Fixing invalid values

cars.CompanyName = cars.CompanyName.str.lower()

def replace_name(a,b):
    cars.CompanyName.replace(a,b,inplace=True)

replace_name('maxda','mazda')
replace_name('porcshce','porsche')
replace_name('toyouta','toyota')
replace_name('vokswagen','volkswagen')
replace_name('vw','volkswagen')

cars.CompanyName.unique()


# In[14]:


#Checking for duplicates

cars.loc[cars.duplicated()]


# In[15]:


cars.columns


# In[16]:


# 3) Visualizing the data


# In[17]:


plt.figure(figsize=(20,8))

plt.subplot(1,2,1)
plt.title('Car Price Distribution Plot')
sns.distplot(cars.price)

plt.subplot(1,2,2)
plt.title('Car Price Spread')
sns.boxplot(y=cars.price)

plt.show()


# In[18]:


print(cars.price.describe(percentiles = [0.25,0.50,0.75,0.85,0.90,1]))


# In[19]:


#Inference :

# 1) The plot seemed to be right-skewed, meaning that the most prices in the dataset are low(Below 15,000).
# 2) There is a significant difference between the mean and the median of the price distribution.
# 3) The data points are far spread out from the mean, which indicates a high variance in the car prices.
# (85% of the prices are below 18,500, whereas the remaining 15% are between 18,500 and 45,400.)


# In[20]:


# 3.1) Visualising Categorical Data


# In[21]:


plt.figure(figsize=(25, 6))

plt.subplot(1,3,1)
plt1 = cars.CompanyName.value_counts().plot('bar')
plt.title('Companies Histogram')
plt1.set(xlabel = 'Car company', ylabel='Frequency of company')

plt.subplot(1,3,2)
plt1 = cars.fueltype.value_counts().plot('bar')
plt.title('Fuel Type Histogram')
plt1.set(xlabel = 'Fuel Type', ylabel='Frequency of fuel type')

plt.subplot(1,3,3)
plt1 = cars.carbody.value_counts().plot('bar')
plt.title('Car Type Histogram')
plt1.set(xlabel = 'Car Type', ylabel='Frequency of Car type')

plt.show()


# In[22]:


#Inference :

# 1) Toyota seemed to be favored car company.
# 2) Number of gas fueled cars are more than diesel.
# 3) sedan is the top car type prefered.


# In[23]:


plt.figure(figsize=(20,8))

plt.subplot(1,2,1)
plt.title('Symboling Histogram')
sns.countplot(cars.symboling, palette=("cubehelix"))

plt.subplot(1,2,2)
plt.title('Symboling vs Price')
sns.boxplot(x=cars.symboling, y=cars.price, palette=("cubehelix"))

plt.show()


# In[24]:


#Inference :

# 1) It seems that the symboling with 0 and 1 values have high number of rows (i.e. They are most sold.)
# 2) The cars with -1 symboling seems to be high priced (as it makes sense too, insurance risk rating -1 is quite good). 
# But it seems that symboling with 3 value has the price range similar to -2 value. There is a dip in price at symboling 1.


# In[25]:


plt.figure(figsize=(20,8))

plt.subplot(1,2,1)
plt.title('Engine Type Histogram')
sns.countplot(cars.enginetype, palette=("Blues_d"))

plt.subplot(1,2,2)
plt.title('Engine Type vs Price')
sns.boxplot(x=cars.enginetype, y=cars.price, palette=("PuBuGn"))

plt.show()

df = pd.DataFrame(cars.groupby(['enginetype'])['price'].mean().sort_values(ascending = False))
df.plot.bar(figsize=(8,6))
plt.title('Engine Type vs Average Price')
plt.show()


# In[26]:


#Inference :

# 1) ohc Engine type seems to be most favored type.
# 2) ohcv has the highest price range (While dohcv has only one row), ohc and ohcf have the low price range.


# In[27]:


plt.figure(figsize=(25, 6))

df = pd.DataFrame(cars.groupby(['CompanyName'])['price'].mean().sort_values(ascending = False))
df.plot.bar()
plt.title('Company Name vs Average Price')
plt.show()

df = pd.DataFrame(cars.groupby(['fueltype'])['price'].mean().sort_values(ascending = False))
df.plot.bar()
plt.title('Fuel Type vs Average Price')
plt.show()

df = pd.DataFrame(cars.groupby(['carbody'])['price'].mean().sort_values(ascending = False))
df.plot.bar()
plt.title('Car Type vs Average Price')
plt.show()


# In[28]:


#Inference :

# 1) Jaguar and Buick seem to have highest average price.
# 2) diesel has higher average price than gas.
# 3) hardtop and convertible have higher average price.


# In[29]:


plt.figure(figsize=(15,5))

plt.subplot(1,2,1)
plt.title('Door Number Histogram')
sns.countplot(cars.doornumber, palette=("plasma"))

plt.subplot(1,2,2)
plt.title('Door Number vs Price')
sns.boxplot(x=cars.doornumber, y=cars.price, palette=("plasma"))

plt.show()

plt.figure(figsize=(15,5))

plt.subplot(1,2,1)
plt.title('Aspiration Histogram')
sns.countplot(cars.aspiration, palette=("plasma"))

plt.subplot(1,2,2)
plt.title('Aspiration vs Price')
sns.boxplot(x=cars.aspiration, y=cars.price, palette=("plasma"))

plt.show()


# In[30]:


#Inference :

# 1) doornumber variable is not affacting the price much. There is no sugnificant difference between the categories in it.
# 2) It seems aspiration with turbo have higher price range than the std(though it has some high values outside the whiskers.)


# In[31]:


def plot_count(x,fig):
    plt.subplot(4,2,fig)
    plt.title(x+' Histogram')
    sns.countplot(cars[x],palette=("magma"))
    plt.subplot(4,2,(fig+1))
    plt.title(x+' vs Price')
    sns.boxplot(x=cars[x], y=cars.price, palette=("magma"))
    
plt.figure(figsize=(15,20))

plot_count('enginelocation', 1)
plot_count('cylindernumber', 3)
plot_count('fuelsystem', 5)
plot_count('drivewheel', 7)

plt.tight_layout()


# In[32]:


#Inference :
    
# 1) Very few datapoints for enginelocation categories to make an inference.
# 2) Most common number of cylinders are four, six and five. Though eight cylinders have the highest price range.
# 3) mpfi and 2bbl are most common type of fuel systems. mpfi and idi having the highest price range. 
# But there are few data for other categories to derive any meaningful inference
# 4) A very significant difference in drivewheel category. Most high ranged cars seeme to prefer rwd drivewheel.


# In[33]:


# 3.2) Visualising numerical data


# In[34]:


def scatter(x,fig):
    plt.subplot(5,2,fig)
    plt.scatter(cars[x],cars['price'])
    plt.title(x+' vs Price')
    plt.ylabel('Price')
    plt.xlabel(x)

plt.figure(figsize=(10,20))

scatter('carlength', 1)
scatter('carwidth', 2)
scatter('carheight', 3)
scatter('curbweight', 4)

plt.tight_layout()


# In[35]:


#Inference :

# 1) carwidth, carlength and curbweight seems to have a poitive correlation with price.
# 2) carheight doesn't show any significant trend with price.


# In[37]:


def pp(x,y,z):
    sns.pairplot(cars, x_vars=[x,y,z], y_vars='price',size=4, aspect=1, kind='scatter')
    plt.show()

pp('enginesize', 'boreratio', 'stroke')
pp('compressionratio', 'horsepower', 'peakrpm')
pp('wheelbase', 'citympg', 'highwaympg')


# In[38]:


# Inference :

# 1) enginesize, boreratio, horsepower, wheelbase - seem to have a significant positive correlation with price.
# 2) citympg, highwaympg - seem to have a significant negative correlation with price.


# In[39]:


np.corrcoef(cars['carlength'], cars['carwidth'])[0, 1]


# In[40]:


# 4) Deriving new features


# In[41]:


#Fuel economy

cars['fueleconomy'] = (0.55 * cars['citympg']) + (0.45 * cars['highwaympg'])


# In[42]:


#Binning the Car Companies based on avg prices of each Company.
cars['price'] = cars['price'].astype('int')
temp = cars.copy()
table = temp.groupby(['CompanyName'])['price'].mean()
temp = temp.merge(table.reset_index(), how='left',on='CompanyName')
bins = [0,10000,20000,40000]
cars_bin=['Budget','Medium','Highend']
cars['carsrange'] = pd.cut(temp['price_y'],bins,right=False,labels=cars_bin)
cars.head()


# In[43]:


# 5)  Bivariate Analysis


# In[44]:


plt.figure(figsize=(8,6))

plt.title('Fuel economy vs Price')
sns.scatterplot(x=cars['fueleconomy'],y=cars['price'],hue=cars['drivewheel'])
plt.xlabel('Fuel Economy')
plt.ylabel('Price')

plt.show()
plt.tight_layout()


# In[45]:


#Inference :

# 1) fueleconomy has an obvios negative correlation with price and is significant.


# In[46]:


plt.figure(figsize=(25, 6))

df = pd.DataFrame(cars.groupby(['fuelsystem','drivewheel','carsrange'])['price'].mean().unstack(fill_value=0))
df.plot.bar()
plt.title('Car Range vs Average Price')
plt.show()


# In[47]:


#Inference :

# 1) High ranged cars prefer rwd drivewheel with idi or mpfi fuelsystem.


# In[48]:


cars_lr = cars[['price', 'fueltype', 'aspiration','carbody', 'drivewheel','wheelbase',
                  'curbweight', 'enginetype', 'cylindernumber', 'enginesize', 'boreratio','horsepower', 
                    'fueleconomy', 'carlength','carwidth', 'carsrange']]
cars_lr.head()


# In[49]:


sns.pairplot(cars_lr)
plt.show()


# In[50]:


# 6) Dummy Variables


# In[51]:


# Defining the map function
def dummies(x,df):
    temp = pd.get_dummies(df[x], drop_first = True)
    df = pd.concat([df, temp], axis = 1)
    df.drop([x], axis = 1, inplace = True)
    return df
# Applying the function to the cars_lr

cars_lr = dummies('fueltype',cars_lr)
cars_lr = dummies('aspiration',cars_lr)
cars_lr = dummies('carbody',cars_lr)
cars_lr = dummies('drivewheel',cars_lr)
cars_lr = dummies('enginetype',cars_lr)
cars_lr = dummies('cylindernumber',cars_lr)
cars_lr = dummies('carsrange',cars_lr)


# In[52]:


cars_lr.head()


# In[53]:


cars_lr.shape


# In[54]:


# 7) Train-Test Split and feature scaling


# In[55]:


from sklearn.model_selection import train_test_split

np.random.seed(0)
df_train, df_test = train_test_split(cars_lr, train_size = 0.7, test_size = 0.3, random_state = 100)


# In[56]:


from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
num_vars = ['wheelbase', 'curbweight', 'enginesize', 'boreratio', 'horsepower','fueleconomy','carlength','carwidth','price']
df_train[num_vars] = scaler.fit_transform(df_train[num_vars])


# In[57]:


df_train.head()


# In[58]:


df_train.describe().T


# In[59]:


#Correlation using heatmap
plt.figure(figsize = (30, 25))
sns.heatmap(df_train.corr(), annot = True, cmap="YlGnBu")
plt.show()


# In[60]:


#Dividing data into X and y variables
y_train = df_train.pop('price')
X_train = df_train


# In[61]:


# 8) Model Building


# In[62]:


#RFE
from sklearn.feature_selection import RFE
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm 
from statsmodels.stats.outliers_influence import variance_inflation_factor


# In[63]:


lm = LinearRegression()
lm.fit(X_train,y_train)
rfe = RFE(lm, 10)
rfe = rfe.fit(X_train, y_train)


# In[64]:


list(zip(X_train.columns,rfe.support_,rfe.ranking_))


# In[65]:


X_train.columns[rfe.support_]


# In[66]:


X_train_rfe = X_train[X_train.columns[rfe.support_]]
X_train_rfe.head()


# In[67]:


def build_model(X,y):
    X = sm.add_constant(X) #Adding the constant
    lm = sm.OLS(y,X).fit() # fitting the model
    print(lm.summary()) # model summary
    return X
    
def checkVIF(X):
    vif = pd.DataFrame()
    vif['Features'] = X.columns
    vif['VIF'] = [variance_inflation_factor(X.values, i) for i in range(X.shape[1])]
    vif['VIF'] = round(vif['VIF'], 2)
    vif = vif.sort_values(by = "VIF", ascending = False)
    return(vif)


# In[68]:


# Model 1


# In[69]:


X_train_new = build_model(X_train_rfe,y_train)


# In[70]:


# p-vale of twelve seems to be higher than the significance value of 0.05, hence dropping it as it is insignificant in presence of other variables.


# In[71]:


X_train_new = X_train_rfe.drop(["twelve"], axis = 1)


# In[72]:


# Model 2


# In[73]:


X_train_new = build_model(X_train_new,y_train)


# In[74]:


X_train_new = X_train_new.drop(["fueleconomy"], axis = 1)


# In[75]:


# Model 3


# In[76]:


X_train_new = build_model(X_train_new,y_train)


# In[77]:


#Calculating the Variance Inflation Factor
checkVIF(X_train_new)


# In[78]:


#dropping curbweight because of high VIF value. (shows that curbweight has high multicollinearity.)


# In[79]:


X_train_new = X_train_new.drop(["curbweight"], axis = 1)


# In[80]:


# Model 4


# In[81]:


X_train_new = build_model(X_train_new,y_train)


# In[82]:


checkVIF(X_train_new)


# In[83]:


#dropping sedan because of high VIF value.


# In[84]:


X_train_new = X_train_new.drop(["sedan"], axis = 1)


# In[85]:


# Model 5


# In[86]:


X_train_new = build_model(X_train_new,y_train)


# In[87]:


checkVIF(X_train_new)


# In[88]:


#dropping wagon because of high p-value.


# In[89]:


X_train_new = X_train_new.drop(["wagon"], axis = 1)


# In[90]:


# Model 6


# In[91]:


X_train_new = build_model(X_train_new,y_train)


# In[92]:


checkVIF(X_train_new)


# In[93]:


# Model 7


# In[94]:


#Dropping dohcv to see the changes in model statistics

X_train_new = X_train_new.drop(["dohcv"], axis = 1)
X_train_new = build_model(X_train_new,y_train)
checkVIF(X_train_new)


# In[95]:


# 9) Residual Analysis of Model


# In[96]:


lm = sm.OLS(y_train,X_train_new).fit()
y_train_price = lm.predict(X_train_new)


# In[97]:


# Plot the histogram of the error terms
fig = plt.figure()
sns.distplot((y_train - y_train_price), bins = 20)
fig.suptitle('Error Terms', fontsize = 20)                  # Plot heading 
plt.xlabel('Errors', fontsize = 18) 


# In[98]:


#Error terms seem to be approximately normally distributed, so the assumption on the linear modeling seems to be fulfilled.


# In[99]:


# 10) Prediction and Evaluation


# In[100]:


#Scaling the test set
num_vars = ['wheelbase', 'curbweight', 'enginesize', 'boreratio', 'horsepower','fueleconomy','carlength','carwidth','price']
df_test[num_vars] = scaler.fit_transform(df_test[num_vars])


# In[101]:


#Dividing into X and y
y_test = df_test.pop('price')
X_test = df_test


# In[102]:


# Now let's use our model to make predictions.
X_train_new = X_train_new.drop('const',axis=1)
# Creating X_test_new dataframe by dropping variables from X_test
X_test_new = X_test[X_train_new.columns]

# Adding a constant variable 
X_test_new = sm.add_constant(X_test_new)


# In[103]:


# Making predictions
y_pred = lm.predict(X_test_new)


# In[104]:


# Evaluation of test via comparison of y_pred and y_test


# In[105]:


from sklearn.metrics import r2_score 
r2_score(y_test, y_pred)


# In[106]:


#EVALUATION OF THE MODEL
# Plotting y_test and y_pred to understand the spread.
fig = plt.figure()
plt.scatter(y_test,y_pred)
fig.suptitle('y_test vs y_pred', fontsize=20)              # Plot heading 
plt.xlabel('y_test', fontsize=18)                          # X-label
plt.ylabel('y_pred', fontsize=16)   


# In[107]:


# Evaluation of the model using Statistics


# In[108]:


print(lm.summary())


# In[ ]:


#Inference :

# 1) R-sqaured and Adjusted R-squared (extent of fit) - 0.899 and 0.896 - 90% variance explained.
# 2) F-stats and Prob(F-stats) (overall model fit) - 308.0 and 1.04e-67(approx. 0.0) - Model fir is significant and explained 90% variance is just not by chance.
# 3) p-values - p-values for all the coefficients seem to be less than the significance level of 0.05. - meaning that all the predictors are statistically significant.

