import cherrypy
import sys
import threading
from PySide.QtCore import *
from PySide.QtGui import *
from copy import deepcopy


filename = "album.png"

cherrypy.config.update({'server.thread_pool': 0})


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


class UpdateThread(QThread):
    slots = 'data'

    def get_data(self):
        QMutexLocker(self.mutex)
        return deepcopy(self.data)

    def set_data(self, data):
        QMutexLocker(self.mutex)
        self.data = deepcopy(data)
        self.emit(SIGNAL("dataReady()"))

    def run(self):
        self.mutex = QMutex()
        while True:
            data = {}

thread = UpdateThread()


class MetroView(QGraphicsView):
    slots = ('album', 'title', 'artist', 'albumart', 'data')

    def __init__(self, scene, parent=None):
        super(MetroView, self).__init__(scene, parent)
        self.thread = thread
        self.connect(self.thread, SIGNAL("dataReady()"), self.update)
        self.thread.start()
        self.initUI()

    def initUI(self):
        # set blackish background

        self.albumart = QPixmap(filename).scaledToWidth(self.scene().sceneRect().width())
        self.setWindowFlags(Qt.FramelessWindowHint)

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
        self.albumart = QPixmap(filename).scaledToWidth(self.scene().sceneRect().width())

    def updateArtistAlbum(self, artist, album):
        self.album.setPlainText("%s - %s" % (artist, album))

    def updateTitle(self, title):
        self.title.setPlainText(title)

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.drawTiledPixmap(self.rect(), self.albumart)
        super(MetroView, self).paintEvent(event)

    def update(self):
        data = self.thread.get_data()
        self.updateTitle(data['title'])
        self.updateArtistAlbum(data['artist'], data['album'])
        self.updateImage()
        self.repaint()

app = QApplication(sys.argv)
view_rect = QRect(100, 100, 600, 600)

scene = QGraphicsScene()
scene.setSceneRect(0.0, 0.0, view_rect.width(), view_rect.height())
view = MetroView(scene)
view.setGeometry(view_rect)
view.show()


class MusicHUD(object):
    def index(self, title, album, artist, albumArt=None):
        global filename
        print threading.current_thread()
        out = """<html>
        <body>
            Title: %s<br />
            Album: %s<br />
            Artist: %s<br />
            albumArt filename: %s<br />
            albumArt mime-type: %s<br />
            temp filename: %s
        </body>
        </html>"""

        if (albumArt):
            filename = 'album.' + albumArt.filename.split('.')[-1]
            savedFile = open(filename, 'wb')
            print('writing file: ' + albumArt.filename)
            savedFile.write(albumArt.file.read())
            savedFile.close()
            out %= (title, album, artist, albumArt.filename,
                    albumArt.content_type, filename)
        else:
            out %= (title, album, artist, "none",
                      "none", filename)
        thread.set_data({'title': title,
                         'artist': artist,
                         'album': album})
        print out
        return out
    index.exposed = True

cherrypy.tree.mount(MusicHUD())
cherrypy.engine.start()
app.exec_()
