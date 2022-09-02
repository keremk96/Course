Liner Regression
STATSMODELS İLE MODELLEME

import statsmodels.api as sm
X = df[["TV"]]
X[0:5]

X = sm.add_constant(X)
X[0:5]

y = df["sales"]
y[0:5]lm = sm.OLS(y,X)
model = lm.fit()
model.summary()import statsmodels.formula.api as smf
lm = smf.ols("sales ~ TV",df)
model =  lm.fit()
model.summary()model.params #b0 and b1 #kat sayılar

model.summary().tables[1] # kat sayılar

model.conf_int() #kat sayıların güven aralığı 

print("f_pvalue: ","%.3f" % model.f_pvalue)
print("s statistic: ","%.3f" % model.fvalue)
print("tvalue: ","%.3f" % model.tvalues[0:1])
model.mse_model
model.rsquared
model.rsquared_adj

model.fittedvalues[0:5] #tahmin edilen değerler
y[0:5] # gerçek değerler

#MODEL DENKLEMİ

print("Sales = " + str("%.2f" % model.params[0]) + " + TV " + "*" + str("%.2f") % model.params[1])import matplotlib.pyplot as plt
g = sns.regplot(df["TV"],df["sales"],ci=None,scatter_kws={"color" : "r","s":9})
g.set_title("Model Denklemi: Sales = 7.03 + TV*0.05")
g.set_ylabel("Satış Sayısı")
g.set_xlabel("TV Harcamaları")
plt.xlim(-10,310)
plt.ylim(bottom=0);from sklearn.linear_model import LinearRegression

X = df[["TV"]]
y = df[["sales"]]
reg = LinearRegression()
model = reg.fit(X,y)

model.intercept_
model.coef_

model.score(X,y) #r-sq değeri
model.predict(X)[0:10] # tahnin edilen değerler

Prediction

X = df[["TV"]]
y = df["sales"]
reg = LinearRegression() #burda nesneyi oluşturduk
model = reg.fit(X,y) #burda fitleme yaptık
model.predict([[30]])Artıklar ve Makine Öğrenmesindeki Önemi

from sklearn.metrics import mean_squared_error, r2_score

lm = smf.ols("sales ~TV",df)
model = lm.fit()
mse = mean_squared_error(y,model.fittedvalues)
rmse = np.sqrt(mse)
reg.predict(X)[0:10]
y[0:10]
k_t = pd.DataFrame({"gercek_y":y[0:10],
                   "tahmin_y":C })

k_t["hata"] = k_t["gercek_y"] - k_t["tahmin_y"]
k_t
k_t["hata_kare"] = k_t["hata"]**2
k_t


np.sum(k_t["hata_kare"])
np.mean(k_t["hata_kare"])
np.sqrt(np.mean(k_t["hata_kare"]))
model.resid[0:10] #artıklarplt.plot(model.resid);
Train-Test Split and feature scaling
from sklearn.model_selection import train_test_split

np.random.seed(0)
df_train, df_test = train_test_split(cars_lr, train_size = 0.7, test_size = 0.3, random_state = 100)from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
num_vars = ['wheelbase', 'curbweight', 'enginesize', 'boreratio', 'horsepower','fueleconomy','carlength','carwidth','price']
df_train[num_vars] = scaler.fit_transform(df_train[num_vars])y_train = df_train.pop('price')
X_train = df_train
Model Building
from sklearn.feature_selection import RFE
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm 
from statsmodels.stats.outliers_influence import variance_inflation_factor


lm = LinearRegression()
lm.fit(X_train,y_train)
rfe = RFE(lm, 10)
rfe = rfe.fit(X_train, y_train)
list(zip(X_train.columns,rfe.support_,rfe.ranking_))
X_train.columns[rfe.support_]
X_train_rfe = X_train[X_train.columns[rfe.support_]]
X_train_rfe.head()

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
    
X_train_new = build_model(X_train_rfe,y_train)
Residual Analysis of Model
lm = sm.OLS(y_train,X_train_new).fit()
y_train_price = lm.predict(X_train_new)

# Plot the histogram of the error terms
fig = plt.figure()
sns.distplot((y_train - y_train_price), bins = 20)
fig.suptitle('Error Terms', fontsize = 20)                  # Plot heading 
plt.xlabel('Errors', fontsize = 18) 
Prediction and Evaluation
#Scaling the test set
num_vars = ['wheelbase', 'curbweight', 'enginesize', 'boreratio', 'horsepower','fueleconomy','carlength','carwidth','price']
df_test[num_vars] = scaler.fit_transform(df_test[num_vars])

#Dividing into X and y
y_test = df_test.pop('price')
X_test = df_test


# Now let's use our model to make predictions.
X_train_new = X_train_new.drop('const',axis=1)
# Creating X_test_new dataframe by dropping variables from X_test
X_test_new = X_test[X_train_new.columns]

# Adding a constant variable 
X_test_new = sm.add_constant(X_test_new)

# Making predictions
y_pred = lm.predict(X_test_new)

# Evaluation of test via comparison of y_pred and y_test
from sklearn.metrics import r2_score 
r2_score(y_test, y_pred)

#EVALUATION OF THE MODEL
# Plotting y_test and y_pred to understand the spread.
fig = plt.figure()
plt.scatter(y_test,y_pred)
fig.suptitle('y_test vs y_pred', fontsize=20)              # Plot heading 
plt.xlabel('y_test', fontsize=18)                          # X-label
plt.ylabel('y_pred', fontsize=16)   

# Evaluation of the model using Statistics
print(lm.summary())

```python

```
