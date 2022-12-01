#!/usr/bin/env python
# -*- coding: utf-8 -*-
import argparse
from os.path import exists

VERBOSE = False
DEBUG = False


def arg():
    global VERBOSE, DEBUG

    p = argparse.ArgumentParser()
    p.add_argument("config", help="Name/path to '.config' file being updated")
    p.add_argument(
        "updates",
        help=
        "File of updates that need to be applied over whatever configuration was generated"
    )
    p.add_argument("-v",
                   "--verbose",
                   help="Increase output verbosity",
                   action="store_true")
    p.add_argument("-d",
                   "--debug",
                   help="Additional printing for debugging purposes",
                   action="store_true")
    args = p.parse_args()

    VERBOSE = args.verbose
    DEBUG = args.debug

    return args


def parse_updates(f):
    tot = list()
    on = list()
    off = list()
    full = list()

    with open(f, "r") as fr:
        tot = [line.rstrip() for line in fr]

    while tot:
        e = tot.pop()
        if "=y" in e:
            on.append(e.split("=y")[0])
        elif "not set" in e:
            off.append(e.split(" ")[1])
        else:
            # Full line replacement
            full.append(e)

    return on, off, full


def ply_updates(cfg, on, off, full):
    global DEBUG

    # Get data from file
    with open(cfg, "r") as f:
        data = f.read()

    # Prep Overflow configs
    eof_additions = ["#", "# Additonal Args for Syzkaller", "#"]

    for e in on:
        if DEBUG:
            print(f"[*] {e} enabled")
        if data.find(f"# {e} is not set") != -1:
            data = data.replace(f"# {e} is not set", f"{e}=y")
        else:
            eof_additions.append(f"{e}=y")

    for e in off:
        if DEBUG:
            print(f"[*] {e} disabled")
        if data.find(f"{e}=y") != -1:
            data = data.replace(f"{e}=y", f"# {e} is not set")
        else:
            eof_additions.append(f"# {e} is not set")

    # TODO Rather than looping through everything, I should write something
    # That find the first value, then seeks to the left and right \n characters
    # partition them into 3 list components, rewrite that middle (1) index
    # and then join them.
    for e in full:
        if DEBUG:
            print(f"[*] {e} replacing line")
        tgt = e.split("=")[0]
        if data.find(tgt):
            tmp = data.splitlines()
            data = "\n".join([e if tgt in entry else entry for entry in tmp])
        else:
            eof_additions.append(e)

    # TODO Write Lines Back To Data
    end = "\n".join(eof_additions)
    if DEBUG:
        print(f"END: {end}")

    data += end

    with open(cfg, "w") as f:
        f.write(data)

    return


def main(ap):
    global VERBOSE, DEBUG

    if DEBUG:
        print("DBG_ARGS: " + str(ap))

    if not exists(ap.config):
        print(f"[-] File {ap.config} does not found")
        return
    if not exists(ap.updates):
        print(f"[-] File {ap.updates} does not found")
        return

    if DEBUG:
        print("[*] Getting updates")
    enable, disable, tune = parse_updates(ap.updates)
    if DEBUG:
        print(f"We will be enabling: {enable}")
        print(f"We will be disabling: {disable}")

    ply_updates(ap.config, enable, disable, tune)

    return


if __name__ == "__main__":
    a = arg()
    main(a)
