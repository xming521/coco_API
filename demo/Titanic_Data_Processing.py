import pandas

df = pandas.read_csv('data.csv')
print(df.head())
df = df.drop('Name', axis=1)
df['Sex'] = df['Sex'].replace('female', '0').replace('male', '1')
df['Embarked_num'] = df.Embarked.map({'S': 0, 'C': 1, 'Q': 2})
df.dropna(subset=['Age', 'Embarked', 'Cabin'], inplace=True)
print(df.head())
df.to_csv('res_data.csv', index=0)
