#!/usr/local/bin/python3

import sys
from pagegen import *

def main():
    if len(sys.argv) == 1:
        buildAndWriteAllPages()
    else:
        pageName = sys.argv[1]
        outStr = buildPage(pageName)
        writePage(pageName, outStr)

if __name__=="__main__":
    main()

