#-*- coding: utf-8 -*-
from lxml import etree
import os, glob, shutil, re, io
from urllib import request

NSMAP = {"tei": "http://www.tei-c.org/ns/1.0", 
          "xml": "http://www.w3.org/XML/1998/namespace",
          "office" :"urn:oasis:names:tc:opendocument:xmlns:office:1.0",
          "text" : "urn:oasis:names:tc:opendocument:xmlns:text:1.0"
          }
    


error_log = {}
error_log['not_valid'] = []
error_log['schema_issue'] = []
error_log['unicode_issue'] = []

parser = etree.XMLParser(dtd_validation=True)

utf8_parser = etree.XMLParser(encoding='utf-8')

def replace_problem_char(strg):
    for pat, repl in [("É", "&#xc9;"), ("’", "&apos;"), ("'", "&apos;"), ("Á", "&#xc1;"), ("á", "&#xe1;"), ("Ó","&#xd3;"), ("Í", "&#xcd;")]:
        expr = re.compile(pat)
    return expr.sub(repl, strg)

def open_file(xml_file):
    #do not encode in unicode when opening, e.g. with codecs module
    
    with open(xml_file, "r+b") as f:
        #s = f.read()
        
        #s = "".join(s.split(r'<?xml version="1.0" encoding="UTF-8"?>'))
        #s = "".join(s.split(r'<?xml version="1.0" encoding="UTF-8" ?>'))
        #s = "".join(s.split(r'<?oxygen RNGSchema="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="xml"?>'))
        #s = "".join(s.split(r'<?oxygen RNGSchema="https://raw.githubusercontent.com/bleierr/Letters-1916-sample-files/master/plain%20corresp%20templates/template.rng" type="xml"?>'))
        
        #print(s[:50])
       
        tree = etree.XML(f.read())
        #return tree
        return tree
    
def validate_with_schema(schema, xml_tree):
    return schema.validate(xml_tree)

      
def write_files_to_disk(lst_files, error_log):
    cwd = os.getcwd()
    new_dir = cwd+os.sep+"result_data2"
    if os.path.isdir(new_dir):
        shutil.rmtree(new_dir)
    valid_dir = new_dir + os.sep+"valid_files"
    problem_dir = new_dir + os.sep+ "problem_files"
    os.mkdir(new_dir)
    os.mkdir(problem_dir)
    os.mkdir(valid_dir)
    
    
    for f_name, xslt_result in lst_files:
        if f_name in error_log['schema_issue']:
            xslt_result.write(problem_dir+os.sep+f_name)
        else:
            xslt_result.write(valid_dir+os.sep+f_name)

    error_log_strg = "{} files have unicode issues:\n".format(len(error_log['unicode_issue']))
    error_log_strg += "\n".join(error_log['unicode_issue'])
    error_log_strg += "\n"
    error_log_strg += "-"*20
    error_log_strg += "\n{} files invalid before transformation:\n".format(len(error_log['not_valid']))
    error_log_strg += "\n".join(error_log['not_valid'])
    error_log_strg += "\n"
    error_log_strg += "-"*20
    error_log_strg += "\n{} files have schema issues:\n".format(len(error_log['schema_issue']))
    error_log_strg += "\n".join(error_log['schema_issue'])
    error_log_strg += "\n"""
    """error_log_strg += "-"*20
    error_log_strg += "\n{} files have TEI_all schema issues:\n".format(len(error_log['tei_schema_issue']))
    error_log_strg += "\n".join(error_log['tei_schema_issue'])"""
    
                                                              
    with open(new_dir+os.sep+"error.log", "w") as f:
        f.write(error_log_strg)

if __name__=='__main__':
    
    cwd = os.getcwd()
    
    #get TEI schema
    """tei_schema_file = cwd + os.sep + 'tei_all.rng'
    with open(tei_schema_file, "r") as f:
        tei_schema_tree = f.read()"""
     
    
    xml_file_path = cwd + os.sep + 'data'
    
    files = os.listdir(xml_file_path)
    
    transformed_files = []
    
    xslt_file = cwd + os.sep + 'copyAndChange.xsl'
    xslt_tree = open_file(xslt_file)
    
    schema_file = 'C:' + os.sep + 'Users' + os.sep + 'Rombli' + os.sep + 'Documents' + os.sep + 'GitHub' + os.sep + 'TEI-sample-files' + os.sep + 'plain corresp templates' + os.sep + 'template.rng'
    schema_tree = open_file(schema_file)
    
    for f_name in files:
        try:
            #print("Now processing file {}".format(f_name))
            t = open_file(xml_file_path+os.sep+f_name)
            if t is not None:
                transform = etree.XSLT(xslt_tree)
                result_tree = transform(t)
                transformed_files.append((f_name, result_tree))
                #valid = validate_with_schema(relaxng, result_tree)
                if result_tree.relaxng(schema_tree) is False:
                    error_log['schema_issue'].append(f_name)
                #valid = TEI schema
                """if result_tree.relaxng(tei_schema_tree) is False:
                    error_log['tei_schema_issue'].append(f_name)"""
            else:
                error_log['not_valid'].append(f_name)
        except UnicodeDecodeError:
            print("Unicode error!")
            """
            with open(xml_file_path+os.sep+f_name, "r") as f:
                error_line = 0
                try:
                    for line in f.readline():
                        error_line+=1
                except UnicodeDecodeError:
                    print(error_line)
            """
            error_log['unicode_issue'].append(f_name)
        except etree.XMLSyntaxError:
            print("XMLSyntaxError error!")
            error_log['not_valid'].append(f_name)
        
     
    write_files_to_disk(transformed_files, error_log)
    
    print('All ok!')




