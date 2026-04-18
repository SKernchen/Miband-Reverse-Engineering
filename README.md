# Miband-Reverse-Engineering
This repository stores the scripts used for the work: "A Methodology for Reverse Engineering Proprietary Bluetooth LE Communication in Xiomi Fitness Trackers"

### helper.py
This tool helps with translating hex to decimal numbers or to the assigned ascii value. It also encrypts the key with an random code with AES used in the authentication process.
It can be used by the command line via 
```bash
python helper.py -V={Value}
```
Where the Value gets translated. Note that the bytes(seperated by space) get translated individually, which makes more sense following the communication.
To use the encrypt function, run
```bash
python helper.py --mode="encrypt" --key={Key} -V={Value}
```
> The key can also be provided in a seperated file in the directory called key.txt.


## Process
To reverse engineer the Mi Band, many actions came in place. Here are all of the commands used provided in different files.
#### discovery.sh
This file show how to see if a Bluetooth adapter is running on your system and if it can find the Mi Band based on the Mac adress.

