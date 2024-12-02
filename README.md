# Diamond Square For Godot
This is an implementation of the diamond square algorithm in Godot using GDScript and can be used to produce heightmap images.
The code is based on the diamond square implementation by WhiteBoxDev: 
<br>
https://github.com/whiteboxdev/example-diamond-square/tree/main?tab=Zlib-1-ov-file

![heightmap_greyscale](https://github.com/user-attachments/assets/4a983d7b-d6d7-4a30-a602-1f867a9be7db)
<br>
This implementation adds falloff to the heightmap, resulting in a height-map that is naturally contained within the bounds of the grid/image.


# Notes:
This algorithm has not been optimized, so heightmaps with resolutions greater than 1024x1024 will be very, very slow to generate.
