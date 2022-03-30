import struct


class BitmapFileHeader:
    def __init__(self, file_name):
        """
        offset - where image starts
        """
        bmp = open(file_name, 'rb')

        self.filename = chr(ord(bmp.read(1))) + chr(ord(bmp.read(1)))
        self.filesize = struct.unpack('I', bmp.read(4))[0]
        bmp.seek(10)
        self.offset = struct.unpack('I', bmp.read(4))[0]

    def __str__(self):
        res = [
            "=FileHeader=",
            f"file name: {self.filename}",
            f"file size: {self.filesize}",
            f"offset: {self.offset}"
        ]
        return '\n'.join(res)


class BitmapInfoHeader:
    def __init__(self, file_name):
        bmp = open("raw.bmp", 'rb')
        bmp.seek(14)

        self.header_size = struct.unpack('I', bmp.read(4))[0]
        self.image_width = struct.unpack('I', bmp.read(4))[0]
        self.image_height = struct.unpack('I', bmp.read(4))[0]
        self.planes = struct.unpack('H', bmp.read(2))[0]
        self.bits_per_pixel = struct.unpack('H', bmp.read(2))[0]
        self.compression = struct.unpack('I', bmp.read(4))[0]
        self.image_size = struct.unpack('I', bmp.read(4))[0]
        self.x_pixel_per_meter = struct.unpack('I', bmp.read(4))[0]
        self.y_pixel_per_meter = struct.unpack('I', bmp.read(4))[0]
        self.total_colors = struct.unpack('I', bmp.read(4))[0]
        self.important_colors = struct.unpack('I', bmp.read(4))[0]

    def __str__(self):
        res = [
            "=InfoHeader=",
            f"header size: {self.header_size}",
            f"image width: {self.image_width}",
            f"image height: {self.image_height}",
            f"planes: {self.planes}",
            f"bits per pixel: {self.bits_per_pixel}",
            f"compression: {self.compression}",
            f"image size: {self.image_size}",
            f"x_pixel_per_meter: {self.x_pixel_per_meter}",
            f"y_pixel_per_meter: {self.y_pixel_per_meter}",
            f"y_pixel_per_meter: {self.y_pixel_per_meter}",
            f"total colors: {self.total_colors}",
            f"important colors: {self.important_colors}",
        ]
        return '\n'.join(res)
