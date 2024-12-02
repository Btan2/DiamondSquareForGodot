# Diamond Square For Godot
This is an implementation of the diamond square algorithm in Godot using GDScript and can be used to produce heightmap images.
The code is based on the diamond square implementation by WhiteBoxDev: 
<br>
https://github.com/whiteboxdev/example-diamond-square/tree/main?tab=Zlib-1-ov-file

<br>

![heightmap_greyscale](https://github.com/user-attachments/assets/4a983d7b-d6d7-4a30-a602-1f867a9be7db)
<br>

# Notes:
* This implementation adds falloff resulting in a height-map that is naturally contained within the bounds of the grid/image.
* This script has not been optimized, *EXPONENT >= 10 will be very, very slow*
* The following values can be edited in the script to influnce the heightmap result: RANDOM_SCALAR, HEIGHT_MIN, HEIGHT_MAX

<br>

*With Falloff*


![faloff](https://github.com/user-attachments/assets/6d295ba1-8d9b-40d0-b554-8473c8dd1bbd)

<br>

*No Falloff*
<br>

![nofalloff](https://github.com/user-attachments/assets/6f9d0837-397b-444b-8db6-bbfd1db6bdad)



