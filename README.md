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

- bugreport
This directory contains snippets of the communication between Mi Band and Smartphone. Most characteristics are already used there and can be determined by looking in the sended commands.
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
> Note that the Handles for Mi Band 4 are used. For Mi Band 5 look into the [characteristics](https://github.com/SKernchen/Miband-Reverse-Engineering/blob/main/characteristics.csv) and use the char handle_5 handle.
- example alert
Shows a message(with vibration) on the Mi Band. Default is "hallo". You can change the text by using the shell parameter and write the message you want, for example:
```
./example_alert.sh "Hello World"
```
- example device name
Prints the Device name in the terminal
- example heart rate
Starts continuous measurement of the heart rate and prints it. The parameter decides the time for how long you want to run it, default is 30 seconds.

### 3_Define_attributes
After auth, every attribute can be tested and explored. This directory holds some example scripts and the results.
In the end, the most undefined attributes are defined and described with the interpretation.
The scripts are:
- read_unknown.sh
Executes a read command.
- notify_on.sh
Sets every notify on descriptor on true.
- write_chars.sh
Executes write with and without answer.
> Note that the Handles for Mi Band 4 are used. For Mi Band 5 look into the [characteristics](https://github.com/SKernchen/Miband-Reverse-Engineering/blob/main/characteristics.csv) and use the char handle_5 handle.
The scripts were used to strategically test the attributes. The Outcomes are also in the directory.

### 4_Examples
Here are Examples with Vendor specific attributes. It works just as in [2_Examples](https://github.com/SKernchen/Miband-Reverse-Engineering#2_examples)
- example activity
Starts an activity (like running) on the Mi Band. Running is default, with the parameter you can change the mode:
| Activity | Code |
| -------|------- |
| Running | 00 |
| Running (treadmile) | 01 |
| Bycicle | 02 |
| Walking | 03 |
| Freestyle | 04 |
| Swimming | 05 |
- example steps
Prints current Steps, Meters and Calories
- example gyroscope
Starts gyroscope, prints average output. The parameter is the running time, default is 15 seconds.

### 5_Miband_5
Shows specific results for Mi Band 5.
