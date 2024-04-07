# -*- coding: utf-8 -*-
"""
Created on Tue Jan 16 11:52:31 2024

@author: ramir
"""

# Assignment #2: "Functions"
# Ramir Aguilo

# Function that takes a string value and returns an integer
def to_number(num_string):
    int_form = int(num_string)
    return int_form

# Function that takes two integers and returns the sum
def add_two(a, b):
    nums_added = a + b
    return nums_added

# Function that takes a numeric value as a parameter, cubes that value
# then returns the resulting numeric value
def cube(num):
    num_cubed = num ** 3
    return(num_cubed)


x = cube(add_two(to_number('5'), to_number('6')))
x = print(x)

