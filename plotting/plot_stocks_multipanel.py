#!/usr/bin/env python

import matplotlib
matplotlib.use('Agg')

from datetime import datetime
import matplotlib.pyplot as plt

class Stock():
    def __init__(self, filename):
        self.time = []
        self.open = []
        self.high = []
        self.low = []
        self.close = []
        self.adjclose = []
        data = [line.strip() for line in open(filename, 'r').readlines()][1:]
        for line in data[::-1]:
            line = line.split(',')
            self.time.append(datetime.strptime(line[0], '%Y-%m-%d'))
            self.open.append(float(line[1]))
            self.high.append(float(line[2]))
            self.low.append(float(line[3]))
            self.close.append(float(line[4]))
            self.adjclose.append(float(line[5]))


datapath = '../data'

stocks = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ', 'IBM', 'INTC', 'MSFT', 'NVDA', 'ORCL']

fig = plt.figure(figsize=(12, 8))
ind = 0
for row in range(5):
    for col in range(2):
        ax = plt.subplot2grid((5, 2),(row, col), colspan=1, rowspan=1)
        stock = stocks[ind]
        s = Stock(datapath + '/' + stock + '.csv')
        ax.tick_params(axis='both', labelsize=10)
        plt.plot(s.time, s.adjclose, 'k-', lw=1)
        plt.text(0.5, 0.8, stock, ha='center', va='bottom', 
                 transform=ax.transAxes, fontsize=12)
        if not row == 4:
            ax.set_xticklabels([])
        plt.grid(True)
        ind += 1

fig.tight_layout()
plt.savefig('adjclose_multipanel.svg')
plt.close(fig)
