#!/usr/bin/env python
# coding: utf-8

# In[11]:


import pandas as pd

ad = pd.read_csv("Advertising.csv")
df = ad.copy()
df.head()


# In[12]:


df = df.iloc[:,1:len(df)] # index'i değişken olarak aldığı için,bu hatadan kurtulma
df.head()


# In[13]:


df.info()


# In[14]:


df.describe().T


# In[16]:


df.isnull().values.any()


# In[17]:


df.corr() # aralalındaki ilişki


# In[20]:


import seaborn as sns
sns.pairplot(df, kind = "reg");


# In[22]:


sns.jointplot(x="TV",y="sales",data=df,kind="reg");


# Statsmodels ile Modelleme

# In[27]:


import statsmodels.api as sm


# In[28]:


X = df[["TV"]]
X[0:5]


# In[29]:


X = sm.add_constant(X)


# In[30]:


X[0:5]


# In[32]:


y = df["sales"]
y[0:5]


# In[35]:


lm = sm.OLS(y,X) #model kurma
model = lm.fit() # modeli fit ettik
model.summary() # modelin çıktılarına erişme

R-squared = Bağımsız değişkenin bağımlı değişkendeki değişkenliği açıklama başarısıdır (burda %60'ı açıklıyor)
Adj-R^2 = daha iyi bir değerdir.
F-statistic = modelin anlamlılığına ilişkin bir değerdir
Prob(F-statistic) = P-value
# In[36]:


import statsmodels.formula.api as smf


# In[37]:


lm = smf.ols("sales ~ TV ",df) #üstteki modelin aynısı (başka bir yol)
model = lm.fit()
model.summary() 


# In[38]:


model.params #b0,b1


# In[39]:


model.summary().tables[1] #kat sayılarla ilişkin değerler


# In[40]:


model.conf_int() # kat sayıların güven aralıkları


# In[41]:


model.f_pvalue #modelin anlamlılığına ilişkin değer


# In[42]:


print("f_pvalue :","%.3f"%model.f_pvalue)


# In[43]:


print("fvalue :","%.3f"%model.fvalue)


# In[44]:


print("tvalue :","%.3f"%model.tvalues[0:1]) #parametre anlalılığına ilişkin değer


# In[45]:


model.mse_model #hata karaler ortalaması


# In[46]:


model.rsquared


# In[47]:


model.rsquared_adj


# In[48]:


model.fittedvalues[0:5] #tahmin edilen değerler


# In[49]:


y[0:5] # gerçek değerler


# In[50]:


#MODEL DENKLEMİ
print("Sales = " + str("%.2f" % model.params[0]) + " + TV " + "*" + str("%.2f") % model.params[1])


# In[51]:


# Modelin Görselleştirilmesi
import matplotlib.pyplot as plt
g = sns.regplot(df["TV"],df["sales"],ci=None,scatter_kws={"color" : "r","s":9})
g.set_title("Model Denklemi: Sales = 7.03 + TV*0.05")
g.set_ylabel("Satış Sayısı")
g.set_xlabel("TV Harcamaları")
plt.xlim(-10,310)
plt.ylim(bottom=0);


# In[52]:


from sklearn.linear_model import LinearRegression


# In[54]:


# Model kurma (başka yöntem)
X = df[["TV"]]
y = df[["sales"]]
reg = LinearRegression()
model = reg.fit(X,y)


# In[55]:


model.intercept_ #b0


# In[56]:


model.coef_ #b1


# In[57]:


model.score(X,y) #r-sq değeri


# In[58]:


model.predict(X)[0:10] # tahnin edilen değerler


# Tahmin

# In[59]:


X = df[["TV"]]
y = df[["sales"]]
reg = LinearRegression()
model = reg.fit(X,y)


# In[60]:


model.predict([[30]]) #denkleme sokar


# In[61]:


yeni_veri = [[5],[90],[200]]


# In[62]:


model.predict(yeni_veri)

