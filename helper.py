from Crypto.Cipher import AES
import argparse

def encrypt(key, text):
    ass = AES.new(bytes.fromhex(key), AES.MODE_ECB)
    ency = ass.encrypt(bytes.fromhex(text))
    return ency.hex()
def translate_hex(hex_text):
    li = list(filter(None, hex_text.split(" ")))
    erg = []
    for i in li:
        erg.append(int(i,16))
    print(erg)
    asc = [chr(x) for x in erg]
    print(asc)
    return erg

def ascii_to_hex(text):
    return text.encode().hex()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="helper",
                                     description="This command helps with Mi Band RE",
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter, )
    parser.add_argument("-k", "--key", help="insert mi band key")
    parser.add_argument("-V", "--value", required=True, help="Value to perform action with")
    parser.add_argument("--mode", default="hex", help="encrypt: performs AES encryption\n"
                                                      "hex: Translates hex to decimal and ascii\n"
                                                    "sth: Performs string to hex")
    args = parser.parse_args()
    mode = args.mode
    key = args.key
    value = args.value
    if mode == "hex":
        translate_hex(value)
    elif mode == "encrypt":
        if key is None:
            with open("key.txt") as f:
                key = f.read()
        print(encrypt(key, value))
    elif mode == "sth":
        print(ascii_to_hex(value))
    else:
        print("An error occurred")
