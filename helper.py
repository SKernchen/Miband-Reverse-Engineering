from Crypto.Cipher import AES
import argparse

def encrypt(key, text):
    ass = AES.new(bytes.fromhex(key), AES.MODE_ECB)
    ency = ass.encrypt(bytes.fromhex(text))
    return ency.hex()
def translate_hex(hex_text, no_utf=False):
    li = list(filter(None, hex_text.split(" ")))
    erg = []
    for i in li:
        erg.append(int(i,16))
    print(erg)
    if no_utf is False:
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
    parser.add_argument("--no-utf", "--no_utf", action='store_true', help="Does not print utf equal")
    args = parser.parse_args()
    mode = args.mode
    key = args.key
    value = args.value
    no_utf = args.no_utf
    if mode == "hex":
        translate_hex(value, no_utf)
    elif mode == "encrypt":
        if key is None:
            with open("key.txt") as f:
                key = f.read()
        print(encrypt(key, value))
    elif mode == "sth":
        print(ascii_to_hex(value))
    else:
        print("An error occurred")
