# -*- coding: utf-8 -*-
"""Alimenta contadores e ranking no Redis a partir de eventos_amostra.csv.
Uso: pip install redis && python sim_eventos_redis.py HOST PORTA SENHA"""
import csv
import sys

import redis

host, porta, senha = sys.argv[1], int(sys.argv[2]), sys.argv[3]
r = redis.Redis(host=host, port=porta, password=senha, decode_responses=True)
print('conectado:', r.ping())

with open('eventos_amostra.csv', encoding='utf-8') as f:
    for ev in csv.DictReader(f):
        if ev['evento'] == 'view':
            r.incr(f"produto:{ev['sku']}:views")
        elif ev['evento'] == 'purchase':
            r.zincrby('vendas:hoje', 1, ev['sku'])

print('top 5:', r.zrevrange('vendas:hoje', 0, 4, withscores=True))
