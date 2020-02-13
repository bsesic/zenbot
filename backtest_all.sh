#!/bin/bash

#./zenbot.sh list-strategies

if [ "$1" != "" ]; then
	selector=$1
else
	echo "no selector given: gdax.BTC-EUR"
	exit 0
fi


strategyArray=( ta_ema trendline trust_distrust macd ta_macd cci_srsi rsi wavetrend sar srsi_macd ta_macd_ext trend_sar srsi_macd ta_macd_ext trend_ema )
_now=$(date +"%m_%d_%Y-%H-%M")
backtestFile="backtest_all-$1-$_now.txt"

./zenbot.sh backfill $selector

for strategy in "${strategyArray[@]}"
do
	echo $strategy >> $backtestFile
	./zenbot.sh sim $selector --strategy=$strategy --period=15m | grep "\<end balance\>" >> $backtestFile
done

exit 0
