#!/usr/bin/env python

import matplotlib
matplotlib.use('Agg')

from datetime import datetime
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


datapath = '..'

stocks = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ',
          'IBM', 'INTC', 'MSFT', 'NVDA', 'ORCL']

startdate = datetime(2017, 1, 1)
enddate = datetime(2018, 1, 1)

for stock in stocks:
    s = Stock(datapath + '/' + stock + '_volatility.txt')
    mask = (np.array(s.time) >= startdate) & (np.array(s.time) <= enddate)

    fig = plt.figure(figsize=(12, 8))
    ax1 = plt.subplot2grid((2, 1), (0, 0), colspan=1, rowspan=1)
    plt.ylim(min(np.array(s.adjclose)[mask]), max(np.array(s.adjclose)[mask]))
    plt.plot(s.time, s.adjclose, 'k-', lw=2)
    plt.plot(s.time, s.mvavg, 'k-', lw=4, alpha=0.4)
    plt.title(stock, fontsize=16)
    plt.ylabel('Adj. close [USD]', fontsize=16)
    ax2 = plt.subplot2grid((2, 1), (1, 0), colspan=1, rowspan=1)
    plt.ylim(0, 15)
    plt.plot(s.time, 100 * np.array(s.mvstd) / np.array(s.mvavg), 'k-', lw=2)
    plt.title(stock, fontsize=16)
    plt.ylabel('Volatility [%]', fontsize=16)
    for ax in [ax1, ax2]:
        ax.set_xlim(startdate, enddate)
        ax.tick_params(axis='both', labelsize=16)
        ax.grid(True)
    plt.savefig(stock + '_volatility.svg')
    plt.savefig(stock + '_volatility.png')
    plt.close(fig)

