#!/usr/bin/env python3

from random import randint
import os
import math

def create_file(file_name):
    if os.path.exists(file_name):
        """answer = str(input("This file already exists do you want to overwrite it ? (y or n)"))
        if answer == 'y':
            os.remove(file)
        else:
            raise SystemError"""
        os.remove(file_name)
    f = open(file_name, 'x')
    return f

def circular_poly(nb_points, nb_poly, file_name):
    f = create_file(file_name+str(nb_points)+".poly")
    i = 0
    while i <= nb_poly:
        v = calculate_circle_points(i+10, nb_points)
        for x, y in v :
            f.write(str(i) + ' ' + str(x) + ' ' + str(y) + '\n')
        i += 1
    f.close()

def circular_poly_pas_imbrique(nb_points, nb_poly, file_name):
    f = create_file(file_name+str(nb_poly)+".poly")
    i = 0
    while i <= nb_poly:
        v = calculate_circle_points(i+10, nb_points)
        for x, y in v:
            f.write(str(i) + ' ' + str(i*2*(i+10)+x) + ' ' + str(y) + '\n')
        i += 1
    f.close()

def imbrique_poly(n, file_name):
    f = create_file(file_name+str(n)+".poly")
    i = 0
    vect = []
    while i <= n:
        f.write(str(i) + ' ' + str(n-i) + ' ' + str(n-i) + '\n')
        f.write(str(i) + ' ' + str(i) + ' ' + str(n-i) + '\n')
        f.write(str(i) + ' ' + str(i) + ' ' + str(i) + '\n')
        f.write(str(i) + ' ' + str(n-i) + ' ' + str(i) + '\n')
        vect += [i-1]
        i += 1
    f.close()
    return vect

def pas_imbrique_poly(n, file_name):
    f = create_file(file_name+str(n)+".poly")
    i = 0
    while i <= n:
        f.write(str(i) + ' ' + str(10*(i+1)) + ' ' + str(10) + '\n')
        f.write(str(i) + ' ' + str(10*i) + ' ' + str(10) + '\n')
        f.write(str(i) + ' ' + str(10*i) + ' ' + str(0) + '\n')
        f.write(str(i) + ' ' + str(10*(i+1)) + ' ' + str(0) + '\n')
        i += 1
    f.close()
    return 

def calculate_circle_points(radius, num_points):
    if num_points < 2:
        raise ValueError("Number of points must be at least 2")

    # Calculate the angle between each point
    angle_step = 2 * math.pi / num_points

    # List to store the coordinates of the points
    points = []

    for i in range(num_points):
        # Calculate the angle for this point
        angle = i * angle_step

        # Calculate the x and y coordinates using trigonometry
        x = radius * math.cos(angle)
        y = radius * math.sin(angle)

        # Append the coordinates to the list of points
        points.append((x, y))

    return points