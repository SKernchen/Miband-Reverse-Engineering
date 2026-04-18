#!/bin/bash
# Find running Bluetooth Interface
a=$(hciconfig)
echo $a
if grep -q "^hci\|UP RUNNING" <<< "$a";
then
  echo "Found Running Bluetooth Interface"
fi

# See if Mi Band can be found
# mac Miband5 = C0:0A:0F:07:3C:01

mac="E0:B2:9B:3E:45:F2"
if grep -q "$mac" <<< "$(bluetoothctl --timeout 5 scan on)";
then
  echo "Found Mac Adress of Mi Band"
fi
