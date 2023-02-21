#!/bin/bash
#
# This is a bash script that can be run on an operating system that
# supports it, e.g. Linux, macOS, or Windows Subsystem for Linux on
# Windows.
#
# Downloads the end of day stock data from the alphavantage.co API.
# The ALPHAVANTAGE_KEY environment variable must be set.

symbols="AMZN MSFT AAPL HPQ IBM CRAY NVDA ORCL INTC CSCO"

for symbol in $symbols; do
    echo $symbol
    url=https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED\&symbol=${symbol}\&outputsize=full\&apikey=${ALPHAVANTAGE_KEY}\&datatype=csv
    curl $url > ${symbol}.csv
done
