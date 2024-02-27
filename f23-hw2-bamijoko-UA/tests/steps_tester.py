import argparse
import os
import pathlib
import json
import re

BASE_PATH = str(pathlib.Path(__file__).absolute().parent.parent.absolute())



def replace_new_line(matched_string):
    if matched_string:
        return matched_string.group(1)+re.sub(r'\n', r'\\n', 
                matched_string.group(2))+matched_string.group(3)
    else:
        return matched_string


def custom_parser(multiline_string):
    if isinstance(multiline_string, (bytes, bytearray)):
        multiline_string = multiline_string.decode()
    multiline_string = re.sub(r'\t', r' ', multiline_string)
    return re.sub(r'(\s*")(.*?)((?<!\\)")', replace_new_line, 
    multiline_string, flags=re.DOTALL)


def main():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('pos_arg', type=int, help='Query number')
    args = parser.parse_args()
    q_num = args.pos_arg
    q_path = BASE_PATH + f"/Q{q_num}/steps.json"

    


    if not os.path.isfile(q_path):
        print(f"{q_path} does not exist")
        exit(1)
    

    steps = None

    try:
        with open(q_path, 'r') as f:
            input_json = custom_parser(f.read())
            steps = json.loads(input_json)
    except Exception as e:
        print("  Json File not valid: " + str(e))
        exit(1)


    root_keys = ["agent", "steps"]
    second_keys = ["thought", "observation", "action", "actionResponse"]

    for k in root_keys:
        if k not in steps:
            print(f"  {k} not in the json file")
            exit(1)

    # if steps['agent'].lower() == 'na':
    #     second_keys += ["action"]
    # else:
    #     second_keys += ["actionPrompt", "actionResponse"]

    if type(steps['steps']) not in (list,tuple):
            print(f"  steps in the file is not a list")
            exit(1)

    for step in steps['steps']:
        if type(step) not in (dict, object):
            print(f"  {step} is not a correct step dict / object")
            exit(1)
        

        for k in second_keys:
            if k not in step:
                print(f"  \"{k}\" should be a key in the step")
                exit(1)

    

    
    print("  All steps file tests passed")
    exit(0)




if __name__ == "__main__":
    main()
