import json

with open('../openapi.json') as f:
    print(type(f))  # <class '_io.TextIOWrapper'>  也就是文本IO类型
    res1 = json.load(f)
    res2 = []
    for key, value in res1['paths'].items():
        # print(value)
        if 'get' in value:
            way: str = 'get'
        else:
            way: str = 'post'
        # way = value['operationId'].split('_')[-1]
        res2.append({
            'name': key,
            'tag': value[way].get('tags', None),
            'way': way.upper(),
            'desc': value[way]['summary']
        })

print(res2)

for i in res2:
    print(f'{i["name"]},{i["tag"]},{i["way"]},{i["desc"]}')
