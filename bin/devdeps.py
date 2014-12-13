#!/usr/bin/env python

import json
import sys


def main(argv):
    with open(argv[0], "r") as jsonFile:
        data = json.load(jsonFile)

    # Only add dependency if not in dependencies or devDependencies
    if data.get('dependencies', False) and argv[1] in data['dependencies'] or \
                    data.get('devDependencies', False) and argv[1] in data['devDependencies']:
        sys.exit(0)

    if data.get('devDependencies', False):
        data['devDependencies'][argv[1]] = argv[2]
    else:
        data['devDependencies'] = {argv[1]: argv[2]}

    with open(argv[0], "w") as jsonFile:
        jsonFile.write(json.dumps(data, indent=2))


if __name__ == "__main__":
    main(sys.argv[1:])
