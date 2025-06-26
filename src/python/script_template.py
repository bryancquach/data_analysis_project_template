"""Template for creating Python scripts.

This is a template script that can be copied to build new scripts that include command line usage
documentation and command line argument handling.

Contributors:
  Bryan Quach (bryancquach@gmail.com)
"""

import argparse

# Command line argument parser
parser = argparse.ArgumentParser(
    prog='script_template.py',
    description='Describe here what this script does.',
    epilog='Optional text at the bottom of help.'
)
parser.add_argument(
    'position_arg1',
    help='Positional argument description.'
)
parser.add_argument(
    '-s',
    '--string_arg1',
    help='String argument description.'
)
parser.add_argument(
    '-i',
    '--int_arg1',
    type=int,
    help='Int argument description.'
)
parser.add_argument(
    '-f',
    '--float_arg1',
    type=float,
    help='Float argument description.'
)
parser.add_argument(
    '-b',
    '--boolean_arg1',
    action='store_true',
    help='Boolean argument description.'
)
args = parser.parse_args()

# Code below to do something with the passed arguments
print(args.position_arg1)
print(args.string_arg1)
print(args.int_arg1)
print(args.float_arg1)
print(args.boolean_arg1)
