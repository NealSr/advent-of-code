#!/usr/bin/python3
from funcy import *
from parse import parse

def bin2dec(bitstring):
    try:
        return parse('{:b}',bitstring)[0]
    except:
        return None

with open('input.txt','r') as file:
    input = file.read().strip()
    Nbits = len(input)*4
    x = parse("{:x}",input)[0]
    input = '{x:0{l}b}'.format(x=x,l=Nbits)

class Packet:
    def __init__(self,bitstring):
        self.bitstring = bitstring
        self.version = bin2dec(bitstring[:3])
        self.typeid  = bin2dec(bitstring[3:6])
        if self.typeid == 4: #literal
            value = 0
            ind = 6
            while bitstring[ind]=='1':
                value += bin2dec(bitstring[ind+1:ind+5])
                value *= 16
                ind += 5
            value += bin2dec(bitstring[ind+1:ind+5])
            self.contents = value
            self.trailing = bitstring[ind+5:]
        else: #operator
            lengthmode = bitstring[6]
            if lengthmode=="0": #total length
                length = bin2dec(bitstring[7:7+15])
                self.contents = []
                self.contents.append(Packet(bitstring[7+15:7+15+length]))
                while self.contents[-1].trailing is not None:
                    self.contents.append(Packet(self.contents[-1].trailing))
                self.trailing = bitstring[7+15+length:]
            else: #number of packets
                numpack = bin2dec(bitstring[7:7+11])
                self.contents = []
                self.contents.append(Packet(bitstring[7+11:]))
                while len(self.contents)<numpack:
                    self.contents.append(Packet(self.contents[-1].trailing))
                self.trailing = self.contents[-1].trailing
        if not bin2dec(self.trailing):
            self.trailing = None


    def __repr__(self):
        return self.contents.__repr__()

    def value(self):
        if self.typeid==4:
            return self.contents
        elif self.typeid==0:
            return sum(x.value() for x in self.contents)
        elif self.typeid==1:
            prod = 1
            for x in self.contents:
                prod*= x.value()
            return prod
        elif self.typeid==2:
            return min(x.value() for x in self.contents)
        elif self.typeid==3:
            return max(x.value() for x in self.contents)
        elif self.typeid==5:
            return int(self.contents[0].value()>self.contents[1].value())
        elif self.typeid==6:
            return int(self.contents[0].value()<self.contents[1].value())
        elif self.typeid==7:
            return int(self.contents[0].value()==self.contents[1].value())

        
        


            



def part1(input=input):
    if type(input) != Packet:
        input = Packet(input)
    if input.typeid == 4:
        return input.version
    else:
        versionsum = input.version
        for c in input.contents:
            versionsum += part1(c)
    return versionsum
    return


def part2(input=input):
    if type(input) != Packet:
        input = Packet(input)
    return input.value()
    return

print(part1())
print(part2())