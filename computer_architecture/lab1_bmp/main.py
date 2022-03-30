from bmp import BitmapFileHeader, BitmapInfoHeader

bmpHeader = BitmapFileHeader("raw.bmp")
bmpInfo = BitmapInfoHeader("raw.bmp")

print(bmpHeader, end='\n\n\n')
print(bmpInfo)

