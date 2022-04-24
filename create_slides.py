import io
import os
import re
import sys


TEX = '.tex'
PDF = '.pdf'
TMP_EXT = '_tmp'
SLIDES_EXT = '-slides'
HANDOUT_EXT = '-handout'

def remove_file_if_existent(file):
    if os.path.exists(file):
            os.remove(file)
            print('-- ' + file + ' removed')

def remove_tex_files(base):
    for ext in ['.aux', '.log', '.nav', '.out', '.snm', '.toc', '.vrb', '.listing', '.synctex.gz']:
        remove_file_if_existent(base + ext)


def read_tutorial():
    pattern = re.compile(r'tut[0-9]{2}')

    try:
        tutorial = sys.argv[1]
    except:
        print('No tutorial given. ')
        tutorial = ''

    while not re.fullmatch(pattern, tutorial):
        tutorial = input('Type the tutorial you want to compile: ')

    return tutorial


tut = read_tutorial()

dir = "." + os.sep + tut + os.sep
os.chdir(dir)


filename_handout = tut + HANDOUT_EXT
filename_slides  = tut + SLIDES_EXT
filename_tmp     = tut + TMP_EXT


# =============================================================================
# OPTIONS
slides_option = "\\documentclass{beamer}\n"
handout_option = "\\documentclass[handout]{beamer}\n"
handout_colours = ['\\setbeamercolor{title}{fg=black}\n',
                   '\\setbeamercolor{author}{fg=black}\n',
                   '\\setbeamercolor{city}{fg=black}\n',
                   '\\setbeamercolor{date}{fg=black}\n',
                   '\\setbeamercolor{normal text}{fg=black,bg=black}\n',
                   '\\setbeamercolor{itemize item}{fg=black}\n',
                   '\\setbeamercolor{background canvas}{bg=white}\n',
                   '\\setbeamercolor{frametitle}{fg=black, bg=cdgray!30}\n',
                   '\\setbeamercolor{block body}{fg=black, bg=cdgray!10}\n',
                   '\\setbeamercolor{block title}{fg=white, bg=cdgray}\n',
                   '\\setbeamercolor{section title}{fg=black}\n',
                   '\n']

# =============================================================================
# OPEN AND READ INPUT
with io.open(tut + TEX, mode='r', encoding='UTF8') as f:
    content = f.readlines()

# =============================================================================
# HANDOUT
with io.open(filename_tmp + TEX, mode='a', encoding='UTF8') as tmp:
    for line in content:
        if '\\documentclass' in line:
            tmp.write(handout_option)
        elif '\\begin{document}' in line:
            tmp.writelines(handout_colours)
            tmp.write(line)
        elif '\\titlegraphic' in line:
            tmp.write(
                '\t\\titlegraphic{\\includegraphics[width=2cm]{../TUD-black.pdf}}\n')
        else:
            tmp.write(line)


# compile .tex file >> .pdf
shell_command = '> texfot pdflatex -jobname=' + \
    filename_handout + ' ' + \
    filename_tmp + TEX

print('Handout compilation ... ')
os.system(shell_command)
os.system(shell_command)
print('... finished.')

# remove files
remove_tex_files(filename_handout)
remove_file_if_existent(filename_tmp + TEX)


# =============================================================================
# SLIDES
with io.open(filename_tmp + TEX, mode='a', encoding='UTF8') as tmp:
    tmp.write(slides_option)
    tmp.writelines(content[1:])

# compile .tex file >> .pdf
shell_command = '> texfot pdflatex -jobname=' + \
    filename_slides + ' ' + \
    filename_tmp + TEX
print('Slides compilation ... ')
os.system(shell_command)
os.system(shell_command)
print('... finished.')

# remove files
remove_tex_files(filename_slides)
remove_file_if_existent(filename_tmp + TEX)

remove_file_if_existent('texfot')

# remove files from compilations done outside of this script
remove_tex_files(tut)
remove_file_if_existent(tut + PDF)