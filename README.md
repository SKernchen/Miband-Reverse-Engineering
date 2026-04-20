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
> First, I tried using bluetoothctl which is the newer tool from bluez for the scripts. But in the auth process it was difficult to access the attributes correctly. So I switched back to the deprecated gatttool, which did the job. Furthermore it was way easier to access all attributes with gatttool.

For the scripts I used tmux to script the normally interactive mode. Tmux enables to start a session independently from the script and send commands to it.
The outcomes are usually scripted in files or the bash itself. But if you want to look into the tmux session, here are some tipps.
To attach the tmux session use `attach-session`. To exit you can type `exit` to kill it or use `Ctr+b` and then `d` to detach it.
In general the following extern (from a normal bash) tmux commands are helpful:
```bash
tmux ls
tmux attach-session -t miband
tmux detach-client -s miband
tmux kill-session -t miband
```

### 1_Discovery
In this directory are the scripts to discover the Mi Band Bluetooth communication.

- discovery.sh
This file show how to see if a Bluetooth adapter is running on your system and if it can find the Mi Band based on the Mac adress.
- list-attributes.sh
Uses bluetoothctl to list all attributes. The output shows also the type of the attribute (service, characteristic or descriptor).
- attributes.sh
Uses gatttool to list all services and characteristics. The output also shows the handle and the permission rights.

With the above mentioned scripts, it was possible to create lists with the important entry-points for the Mi Band:
- primary.csv: shows all services with UUID and handle range
- characteristics.csv: shows all characteristics with UUID, handle, characteristic handle and characterisitc permission
- undefined_attributes.csv: shows all characteristics that have an unknown purpose at this point

### Auth
Most access points need authentification to work. With auth.sh the Mi Band gets connected and authenticated.
Therefore the Mac address needs to be adapted and the auth key needs to be provided (see helper.py).
The auth key can be retrieved with a rooted phone or with https://www.freemyband.com/.

After auth you can get into the interactive gatttool and try everythin by attaching the tmux session with:
```bash
tmux attach-session -t miband
```
Or you can try out the examples in the normal bash:

### 2_Examples
Here are some example scripts to show the access to the attributes. The auth script has to be run before the example, cause they are using the tmux session created in auth.

### 3_Define_attributes
After auth, every attribute can be tested and explored. This directory holds some example scripts and the results.
In the end, the undefined attributes are defined(most) and described with the interpretation.

