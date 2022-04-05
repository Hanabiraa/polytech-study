import shutil

from bmp import BitmapFileHeader, BitmapInfoHeader, ImageData

# copy file
old_file_name = "raw_clean.bmp"
new_file_name = "converted.bmp"
shutil.copyfile(old_file_name, new_file_name)

# info
bmpHeader = BitmapFileHeader(new_file_name)
bmpInfo = BitmapInfoHeader(new_file_name)
image = ImageData(bmpHeader, bmpInfo, new_file_name)

# print info
print(bmpHeader, end='\n\n\n')
print(bmpInfo)

# convert
image.covert_to_32(alpha=50)
image.write()
