import argparse
def get_steps(step_string):
	li = list(filter(None, step_string.split(" ")))
	erg = []
	steps=int("".join([li[4],li[3],li[2],li[1]]),16)
	meters=int("".join([li[8],li[7],li[6],li[5]]),16)
	cals=int("".join([li[12],li[11],li[10],li[9]]),16)
	print("steps: {steps}, meters: {meters}, calories: {cals}".format(steps=steps,meters=meters,cals=cals))
	

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="helper",
                                     description="This command helps with reading Mi Band Features",
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter, )
    parser.add_argument("-V", "--value", required=True, help="Value to perform action with")
    parser.add_argument("--output", default="hex", help="steps: reads step string\n")
    args = parser.parse_args()
    output = args.output
    value = args.value
    if output == "steps":
        get_steps(value)
        
