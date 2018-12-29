

import xml.etree.ElementTree as ET
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import ks_2samp

## ===== Settings ===== ##

XML_FNAME = "XY_floret_dendrogram.xml"

## =================== ##

def recursive_lookup(segment,branch):

    for i,subbranch in enumerate(branch):
        new_segment = Segment(subbranch.attrib['start'], subbranch.attrib['end'], subbranch.attrib['length'])
        recursive_lookup(new_segment, subbranch)
        segment.children.append(new_segment)

def find_children(segment,children,level=0):
    if len(segment.children)!=0:
        for child in segment.children:
            new_level = level+1
            find_children(child,children,new_level)

    if level>0:
        children.append(segment)
    else:
        return children

def find_children_set(segment,terminal,inter,level=0):
    if len(segment.children)!=0:
        for child in segment.children:
            new_level = level+1
            find_children_set(child,terminal,inter,new_level)

    if level>0:
        if len(segment.children)==0:
            terminal.append(segment)
        else:
            inter.append(segment)

    else:
        return terminal,inter

class Tree():
    def __init__(self,id):
        self.id = id
        self.children = []

class Segment():
    def __init__(self, start, end, length):
        self.start = self.stringToFloats(start)
        self.end = self.stringToFloats(end)
        self.length = float(length)
        self.children = []

    def stringToFloats(self, string):
        num_arr = []
        split = string.split(',')
        for number in split:
            num_arr.append(float(number))
        return num_arr

## Parse XML into custom python tree stucture

tree = ET.parse(XML_FNAME)
cell = tree.getroot().find('cell')

trees = []
ids = []
n=0
for axon in cell:
    id = axon.attrib['id']
    ids.append(int(id))
    tree = Tree(id)
    for branch in axon:
        segment= Segment(branch.attrib['start'], branch.attrib['end'], branch.attrib['length'])
        recursive_lookup(segment,branch)
        tree.children.append(segment)
    trees.append(tree)

    n+=1
    # if n==50:         ## Can limit the number of tree shown with this
    #     break

segments_lengths = []
term_lengths = []
inter_lengths = []
colours = []
for i,tree in enumerate(trees):
    # if i==5:
    children,inter_children,term_children=[],[],[]
    find_children(tree,children)
    find_children_set(tree,term_children,inter_children)
    for child in children:
        segments_lengths.append(child.length)
    for child in inter_children:
        inter_lengths.append(child.length)
    for child in term_children:
            term_lengths.append(child.length)



segments_lengths=np.array(segments_lengths)
inter_lengths = np.array(inter_lengths)
term_lengths = np.array(term_lengths)

segments_lengths = segments_lengths[segments_lengths>1]
inter_lengths = inter_lengths[inter_lengths>1]
term_lengths = term_lengths[term_lengths>1]

print('Num segments: ',len(segments_lengths))
print('Num intermediate segments: ',len(inter_lengths))
print('Num terminal segments: ',len(term_lengths))

print('Mean intermediate segments:', np.mean(inter_lengths))
print('Mean terminal segments:', np.mean(term_lengths))


plot = plt.figure()
# plt.subplot(3,1,1)
# plt.title("All segments")
# axes = plt.gca()
# axes.set_xlim([0,600])
# plt.hist(segments_lengths,160,color = "green")
# plt.ylabel('Frequency')
plt.subplot(2,1,1)
plt.title("Intermediate segments")
axes = plt.gca()
axes.set_xlim([0,600])
axes.set_ylim([0,120])
plt.hist(inter_lengths,160,color = "green")
plt.ylabel('Frequency')
plt.subplot(2,1,2)
plt.title("Terminal segments")
axes = plt.gca()
axes.set_xlim([0,600])
axes.set_ylim([0,120])
plt.hist(term_lengths,160,color = "green")
plt.ylabel('Frequency')
plt.xlabel("Segment-length [microns]")
plt.tight_layout()
plt.show()
plot.savefig('Terminal_Intermediate.eps', format='eps', dpi=100)

print(ks_2samp(inter_lengths, term_lengths))




