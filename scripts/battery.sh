#!/bin/sh

low=20
critical=10
hibernate=5

updatepercent() {
	charge=$(cat /sys/class/power_supply/BAT1/charge_now)
	charge_full=$(cat /sys/class/power_supply/BAT1/charge_full_design)
	percent=$(expr $charge \* 100 / $charge_full)
}

low_not_sent=1
critical_not_sent=1
hib_not_sent=1

while :
do
	updatepercent

	# Check if charging
	if [ $(cat /sys/class/power_supply/BAT1/status) = "Charging" ]; then
		low_not_sent=1
		critical_not_sent=1
		hib_not_sent=1

	# Hibernate
	elif [ $percent -le $hibernate -a "$hib_not_sent" ]; then
		notify-send -u critical -i battery-caution -t 120000 "Fatal" "Hibernating due to low battery: $percent%"
		hib_not_sent=
		critical_not_sent=
		low_not_sent=
		sleep 5
		systemctl hibernate

	# Critical
	elif [ $percent -le $critical -a "$critical_not_sent" ]; then
		notify-send -u critical -i battery-caution -t 120000 "Warning" "Battery critically low: $percent%"
		critical_not_sent=
		low_not_sent=

	# Low
	elif [ $percent -le $low -a "$low_not_sent" ]; then
		notify-send -u critical -i battery-low -t 120000 "Warning" "Battery Low: $percent%"
		low_not_sent=
	fi

	#echo $percent
	sleep 60
done

