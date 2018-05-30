#!/usr/local/bin/python3

import sys
from pathlib import Path
import pypandoc

globalFooter = ""

def generateHeader(pageName):
    outStr = ""
    siteName=""
    styleFile=""
    keywordsFile=""
    faviconURL=""
    outFile="test/" + pageName + ".html"
    outStr = "<!DOCTYPE html><html><head>";
    
    if pageName == "":
        outStr += "<title>" + siteName + "</title>"
    else:
        outStr += "<title>" + siteName + " | " + pageName + "</title>"
    outStr += "<link rel=\"icon\" type=\"image/png\" href=\"" + faviconURL + "\" />"

    # check to see if styleFile and keywordsFile exist
    styleFileExists = Path(styleFile).is_file()
    keywordsFileExists = Path(keywordsFile).is_file()

    if not styleFileExists:
        print("styleFile does not exist")
        sys.exit(-1)
    if not keywordsFileExists:
        print("keywordsFile does not exist")
        sys.exit(-1)

    outStr += "<meta charset=\"UTF-8\"/><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/><meta name=\"keywords\" content=\""

    keywordsStr = ""
    with open(keywordsFile, "r") as infile:
        keywordsStr = infile.read().replace('\n', ', ')
    keywordsStr = keywordsStr.rstrip()
    keywordsStr = keywordsStr[0:len(keywordsStr)-1]
    outStr += keywordsStr + "\" />"

    styleHeaderStr = ""
    with open(styleFile, "r") as infile:
        styleHeaderStr = infile.read()
    outStr += styleHeaderStr
    return outStr

def generateHTML(filePath):
    if Path(filePath).is_file():
        return pypandoc.convert_file(filePath, 'html')
    return ""

def getFooter(filePath):
    global globalFooter 
    if globalFooter == "":
        if Path(filePath).is_file():
            with open(filePath) as infile:
                globalFooter = infile.read()
    return globalFooter

def buildPage(pageName):
    footerFile = ""
    inputFilePath = "pages/" + pageName + ".md"
    footerFilePath = "footer.html"
    headerStr = generateHeader(pageName)
    htmlStr = generateHTML(inputFilePath)
    footerStr = getFooter(footerFile)
    return headerStr + "\n" + htmlStr + "\n" + footerStr + "\n"

def writePage(pageName, outputStr):
    outputFileFolder = "test/"
    outputFilePath = outputFileFolder + pageName + ".html"
    with open(outputFilePath, "w+") as outfile:
        outfile.write(outputStr)

def buildAndWriteAllPages():
    print("buildAndWriteAllPages")
    pagesFilePath = ""
    with open(pagesFilePath, "r") as infile:
        lines = infile.readlines()
        for i in range(0,len(lines)):
            pageName = lines[i].rstrip()
            print("[%d/%d] building %s..." % (i , len(lines) , pageName))
            outputStr = buildPage(pageName)
            writePage(pageName, outputStr)

