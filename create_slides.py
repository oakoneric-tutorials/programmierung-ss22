import io
import os
import re
import sys


TEX = '.tex'
PDF = '.pdf'
TMP_EXT = '_tmp'
SLIDES_EXT = '-slides'
HANDOUT_EXT = '-handout'


def remove_tmp_files(filename, tmp):
    for end in ['.aux', '.log', '.nav', '.out', '.snm', '.toc', '.vrb', '.listing']:
        if os.path.exists(filename + end):
            os.remove(filename + end)
    os.remove(tmp + TEX)


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


tutorial = read_tutorial()


dir = "." + os.sep + tutorial + os.sep
filename = tutorial
filename_handout = tutorial + HANDOUT_EXT
filename_slides = tutorial + SLIDES_EXT
filename_tmp = tutorial + TMP_EXT

os.chdir(dir)

# =============================================================================
# OPEN AND READ INPUT
with io.open(filename + TEX, mode='r', encoding='UTF8') as f:
    content = f.readlines()

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

remove_tmp_files(filename_handout, filename_tmp)


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

remove_tmp_files(filename_slides, filename_tmp)

os.remove('texfot')
