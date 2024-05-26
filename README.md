# Cuis-Smalltalk-WallpaperEngine

## Description:
Allows you to customize the Cuis wallpaper with solid colors, images, or animated wallpapers.

## Requirements:
You will need in the root folder the example file `StaticExample.jpg` and the example folder `DynamicExample` found in the repository.
> In the future, I will look for a way to include these test files and examples in the package.

## Usage:
I recommend using the visual interface, put in the workspace:

`WallpaperEngineWindow open`

On the left, you will see a list of available examples, on the right a preview, and just below the following buttons:
### Add
  First, enter the name you want to give your wallpaper, then you can choose to enter different options:
  
  - Solid color, for example `#eb5e34`
  - Image, for example `example.jpg` or `path/example.jpg`
  - Animated wallpaper, for example `path/exampleDirectory`. The directory should contain the sequence of images in the order you want to animate them.
> For animated wallpapers, I recommend using a few images, between 6 and 10 frames.
> 
> Decomposing a .GIF into several .JPGs using some web tool is a good option for obtaining animated wallpapers. In the future, I will look for a way to use .GIF files directly.
### Remove
  Allows you to remove the selected wallpaper from the list, except for the default one.
### Apply
  Applies the wallpaper. Depending on the type of wallpaper, it may take a few seconds, especially if it is an animated wallpaper with many images.

---
 
### Sebastian M. Vintoñuke
### Contact Information:

- [GitHub](https://github.com/SebastianVintonuke)
- [LinkedIn](https://www.linkedin.com/in/sebastian-vintoñuke-7ab06a161/)
- sebastian.m.vintonuke@gmail.com
