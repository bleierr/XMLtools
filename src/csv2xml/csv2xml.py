'''
Created on 9 Dec 2015

@author: Rombli

csv2xml module: was developed to transform csv into xml 
The XML output can be controlled with XSLT files
The path of XML input, XSLT and XML output files has to be declared in the dataFiles list below


'''
import csv
import os, shutil
from lxml import etree

ERROR_LOG = []

def applyXsltToEtree(xsltFilePath, xmlEtree):
    with open(xsltFilePath, "r+b") as f:
        xsltTree = etree.XML(f.read())
    transform = etree.XSLT(xsltTree)
    return transform(xmlEtree)


def testElementName(eleName):
    #make sure no whitespace in element names
    eleName = "_".join(eleName.split())
    if eleName.strip() == "":
        eleName = "_ERROR"                        
    return eleName
    

def etreeFromCsv(csvFilePath):
    tabel = etree.Element("tabel")
    with open(csvFilePath) as csvfile:
        reader = csv.DictReader(csvfile)
        try:
            for line in reader:
                row = etree.Element("row")
                for columnName, value in line.items():
                    #make sure no space in element name
                    columnName = testElementName(columnName)
                    ele = etree.Element(columnName)
                    ele.text = value
                    row.append(ele)
                tabel.append(row)
        except UnicodeDecodeError as e:
            ERROR_LOG.append("Unicode error: {}".format(e))
            print("ERROR: {}".format(e))
    return tabel

if __name__ == '__main__':
    cwd = os.getcwd()
    
    csvFileDir = cwd + os.sep + "IDlists"
    
    xsltFileDir = cwd + os.sep + "xslt"
    
    resultFileDir = cwd + os.sep + "resultXml"
    if os.path.isdir(resultFileDir):
        shutil.rmtree(resultFileDir)
    os.mkdir(resultFileDir)
    
    dataFiles = [ ("PlaceList-GeoCoordinates.csv", "PlaceList-GeoCoordinates.xml", "toPlaceList.xsl"),
                 ("person_ID - persName.csv", "PersonList.xml", "toPersonList.xsl"),
                 ("institution_ID - Foglio1.csv", "institutionList.xml", "toInstitutionList.xsl")
                ]
    
    print("An output folder was created {}".format(resultFileDir))
    
    for csvFile, resultFile, xsltFile in dataFiles:
        xmlEtree = etreeFromCsv(csvFileDir + os.sep + csvFile)
        resultTree = applyXsltToEtree(xsltFileDir + os.sep + xsltFile, xmlEtree)
        resultTree.write(resultFileDir + os.sep + resultFile)
        print("Output file created {}".format(resultFileDir + os.sep + resultFile))
     
       
        
    if len(ERROR_LOG) > 0:
        with open(resultFileDir + os.sep + "error.log", "w") as f:
            f.write("\n".join(ERROR_LOG))
            
            print("Error Log created {}".format(resultFileDir + os.sep + "error.log"))
    
    print("Done!")