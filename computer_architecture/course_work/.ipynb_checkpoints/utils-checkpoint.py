import os

import numpy as np
import matplotlib.pyplot as plt

import tensorflow as tf
from keras.layers import Dense, Flatten, Reshape, Input, InputLayer
from keras.models import Sequential, Model
from sklearn.model_selection import train_test_split
import cv2

from typing import List, Any

def crop_imgs(paths: List[str], x:int, y:int, width:int, height:int, color_type_changer=None) -> List[Any]:
    """
    Обрезка изображений в формат 64х64 пикселя
    
    paths - пути к изображениям
    x, y - начальные координаты коориднаты для обрезания
    width, height - конечные коориднаты для обрезания
    color_type_changer - при необходимости перекодировка каналов цвета, прим. cv2.COLOR_BGR2RGB
    
    return - изображения ввиде numpy.ndarray
    """
    imgs = []
    for f_path in paths:
        img = cv2.imread(f_path)
        if color_type_changer:
            img = cv2.cvtColor(img, color_type_changer)
        imgs.append(img[x:x+width, y:y+height])
    return np.array(imgs)

def img_table(imgs: np.ndarray, path=None):
    """
    Создание таблицы из всех изображений с границей в 1 пиксел.
    RGB коды в формате 0-255
    
    imgs - массив изображений
    path: str - путь для сохранения картинки в формате png
    """
    img_h, img_w = imgs.shape[1:3]
    n_plots = int(np.ceil(np.sqrt(imgs.shape[0])))
    table = np.ones(
        (imgs.shape[1] * n_plots + n_plots + 1,
        imgs.shape[2] * n_plots + n_plots + 1,
        3))
    for i in range(n_plots):
        for j in range(n_plots):
            idx = i * n_plots + j
            if idx < imgs.shape[0]:
                img = imgs[idx]
                table[1 + i + i * img_h:1 + i + (i + 1) * img_h,
                  1 + j + j * img_w:1 + j + (j + 1) * img_w] = img
    table = table.astype(np.uint8)
    if path:
        plt.imsave(arr=table, fname=path)
    return table