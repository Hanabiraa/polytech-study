import struct
from typing import List


class Pixel24:
    """
    Represent pixel in 24-bit format
    """

    def __init__(self, r, g, b):
        self.r = r
        self.g = g
        self.b = b

    def write(self, file) -> None:
        """
        Write in xxx.bmp file in right order pixel
        :param file: file BINARY stream object
        :return: None
        """
        for arg in [self.b, self.g, self.r]:
            file.write(
                struct.pack('B', arg)
            )


class Pixel32:
    """
    Represent pixel in 32-bit format
    """

    def __init__(self, a, r, g, b):
        self.a = a
        self.r = r
        self.g = g
        self.b = b

    def write(self, file) -> None:
        """
        Write in xxx.bmp file in right order pixel
        :param file: file BINARY stream object
        :return: None
        """
        for arg in [self.b, self.g, self.r, self.a, ]:
            file.write(
                struct.pack('B', arg)
            )


class BitmapFileHeader:
    """
    Represent File Header for bmp image
    """

    def __init__(self, file_name):
        with open(file_name, 'rb') as bmp:
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

    # TODO: record headers if needed
    def write(self, file):
        ...


class BitmapInfoHeader:
    """
    Represent Info Header for bmp image
    """

    def __init__(self, file_name):
        with open(file_name, 'rb') as bmp:
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

    # TODO: record headers if needed
    def write(self, file):
        # write header
        file.seek(28, 0)
        file.write(struct.pack('H', self.bits_per_pixel))

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


class ImageData:
    """
    Represent image byte data
    """

    def __init__(self, bmp_header, bmp_info, file_name):
        self.bmp_file = file_name
        self.bmp_file_header = bmp_header
        self.bmp_info_header = bmp_info
        self.byte_in_row = self.bmp_file_header.filesize // self.bmp_info_header.image_height
        self.pixels = self.byte_in_row // 3
        self.bmp_list = self.__read_pixels24()

    def __read_pixels24(self) -> List[List[Pixel24]]:
        """
        Read file per byte and build pixel in 24-bit pixel format.
        Create 2-dim array of pixels, where:
            1 dim - str
            2 dim - pixels in str
        :return: List[List[Pixel24]]
        """
        bmp_list_ = []
        with open(f"{self.bmp_file}", 'rb') as bmp:
            bmp.seek(self.bmp_file_header.offset, 0)
            for line in range(self.bmp_info_header.image_height):
                bmp_line = []
                for byte in range(self.pixels):
                    b = struct.unpack('B', bmp.read(1))[0]
                    g = struct.unpack('B', bmp.read(1))[0]
                    r = struct.unpack('B', bmp.read(1))[0]
                    pixel = Pixel24(
                        r=r,
                        g=g,
                        b=b
                    )
                    bmp_line.append(pixel)
                bmp_list_.append(bmp_line)
        return bmp_list_

    def covert_to_32(self, alpha=255) -> None:
        """
        Read file per byte and build pixel in 32-bit pixel format.
        Create 2-dim array of pixels, where:
            1 dim - str
            2 dim - pixels in str
        self.bmp_list = List[List[Pixel32]]

        change attributes dependent on this:
        - byte_in_row
        - bmpInfo.bits_per_pixel

        :return: None
        """

        bmp_list_32 = []
        for line in self.bmp_list:
            bmp_line = []
            for pixel24 in line:
                bmp_line.append(
                    Pixel32(
                        a=alpha,
                        r=pixel24.r,
                        g=pixel24.g,
                        b=pixel24.b
                    )
                )
            bmp_list_32.append(bmp_line)
        self.bmp_list = bmp_list_32
        self.byte_in_row = self.pixels * 4
        self.bmp_info_header.bits_per_pixel = 32

    def write(self) -> None:
        """
        Write in bmp file all headers and image in right order
        :return: None
        """
        with open(self.bmp_file, 'rb+') as bmp:
            self.bmp_file_header.write(bmp)
            self.bmp_info_header.write(bmp)
            self.__write(bmp)
            print("\n\nConvert!")

    def __write(self, file) -> None:
        file.seek(self.bmp_file_header.offset, 0)
        for line in self.bmp_list:
            for pixel in line:
                pixel.write(file)
