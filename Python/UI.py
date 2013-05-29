#!/usr/bin/python
# -*- coding: utf-8 -*-


import sys
from PySide.QtCore import *
from PySide.QtGui import *

filename = "album.jpg"


class Style:
    '''Style constants'''

    # margin for all ui components
    component_margin = 24
    
    body_text_size = 36
    header_text_size = 72
    
    # ui fonts and color
    header_font = QFont("Segoe UI", header_text_size, 10)
    body_font = QFont("Segoe UI", body_text_size, 10)
    ui_text_color = Qt.white
    background_style = "background-color: rgba(26,26,26)"


class MetroView(QGraphicsView):
    slots = ('album', 'title', 'artist','albumart')

    def __init__(self, scene, parent=None):
        super(MetroView, self).__init__(scene, parent)
        self.initUI()
        
    def initUI(self):
        # set blackish background
        self.setWindowFlags(Qt.FramelessWindowHint)
        self.albumart = QPixmap(filename).scaledToHeight(QDesktopWidget().availableGeometry().height())

        self.title = QGraphicsTextItem()
        self.title.setAcceptHoverEvents(False)
        self.title.setFont(Style.header_font)
        self.title.setPlainText("It's Alright")
        self.title.setDefaultTextColor(Style.ui_text_color)
        self.title.setPos(20, self.scene().sceneRect().height() - 185)
        self.scene().addItem(self.title)

        self.album = QGraphicsTextItem()
        self.album.setAcceptHoverEvents(False)
        self.album.setFont(Style.body_font)
        self.album.setPlainText("%s - %s" % ('Matt and Kim', 'Lightning'))
        self.album.setDefaultTextColor(Style.ui_text_color)
        self.album.setPos(20, self.scene().sceneRect().height() - 80)
        self.scene().addItem(self.album)
        
    def updateImage(self):
        self.albumart = QPixmap(filename).scaledToHeight(QDesktopWidget().availableGeometry().height())

    def updateArtistAlbum(self, artist, album):
        self.album.setPlainText("%s - %s" % (artist, album))

    def updateTitle(self, title):
        self.title.setPlainText(title)

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.drawTiledPixmap(self.rect(), self.albumart)
        super(MetroView, self).paintEvent(event)

    def update(self, title, artist, album):
        self.updateTitle(title)
        self.updateArtistAlbum(artist, album)
        self.updateImage()
        self.repaint()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    view_rect = QRect(100, 100, 1366, 768)

    scene = QGraphicsScene()
    scene.setSceneRect(0.0, 0.0, view_rect.width(), view_rect.height())
    view = MetroView(scene)
    view.setGeometry(view_rect)
    view.show()


    title = input("Title: ")
    album = input("Album: ")
    artist = input("Artist: ")
    view.update(title, artist, album)
    app.exec_()