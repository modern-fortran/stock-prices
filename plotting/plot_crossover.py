#!/usr/bin/env python

import matplotlib
matplotlib.use('Agg')

from datetime import datetime
from matplotlib.dates import date2num
import matplotlib.pyplot as plt
import numpy as np

class Stock():
    def __init__(self, filename):
        self.time = []
        self.adjclose = []
        self.mvavg = []
        self.mvstd = []
        data = [line.strip() for line in open(filename, 'r').readlines()]
        for line in data:
            line = line.split()
            self.time.append(datetime.strptime(line[0], '%Y-%m-%d'))
            self.adjclose.append(float(line[1]))
            self.mvavg.append(float(line[2]))
            self.mvstd.append(float(line[3]))

def read_crossover(filename):
    data = [line.strip() for line in open(filename, 'r').readlines()]
    buy = []
    sell = []
    for line in data:
        line = line.split()
        if line[0] == 'Buy':
            buy.append(datetime.strptime(line[1], '%Y-%m-%d'))
        else:
            sell.append(datetime.strptime(line[1], '%Y-%m-%d'))
    return buy, sell


datapath = '..'

stocks = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ',
          'IBM', 'INTC', 'MSFT', 'NVDA', 'ORCL']

startdate = datetime(2017, 1, 1)
enddate = datetime(2018, 1, 1)

up_arrow, down_arrow = u'$\u2191$', u'$\u2193$'

for stock in stocks:

    print(stock)
    s = Stock(datapath + '/' + stock + '_volatility.txt')
    buy, sell = read_crossover(datapath + '/' + stock + '_crossover.txt')

    mask = (np.array(s.time) >= startdate) & (np.array(s.time) <= enddate)

    fig = plt.figure(figsize=(12, 6))
    ax = fig.add_subplot(111, xlim=(startdate, enddate))
    ax.tick_params(axis='both', labelsize=16)
    plt.ylim(min(np.array(s.adjclose)[mask]), max(np.array(s.adjclose)[mask]))
    plt.plot(s.time, s.adjclose, 'k-', lw=2)
    plt.plot(s.time, s.mvavg, 'k-', lw=4, alpha=0.4)
    datenum = date2num(s.time)
    for t in sell:
        n = np.argmin((datenum - date2num(t))**2)
        plt.plot(s.time[n], s.adjclose[n], linestyle=None,
                 marker=down_arrow, color='r', ms=18)
    for t in buy:
        n = np.argmin((datenum - date2num(t))**2)
        plt.plot(s.time[n], s.adjclose[n], linestyle=None,
                 marker=up_arrow, color='g', ms=18)
    plt.title(stock, fontsize=16)
    plt.ylabel('Adj. close [USD]', fontsize=16)
    plt.title(stock, fontsize=16)
    plt.grid(True)
    plt.savefig(stock + '_crossover.svg')
    plt.savefig(stock + '_crossover.png')
    plt.close(fig)

