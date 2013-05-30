import cherrypy
import sys
import threading
from PySide.QtCore import *
from PySide.QtGui import *
from copy import deepcopy


filename = "album.png"

#cherrypy.config.update({'server.thread_pool': 0})


class Style:
    '''Style constants'''

    # ui fonts and color
    ui_text_color = '#F8F8F8'
    background_color = QColor(25, 25, 25, 213)

    def title_font(self, sceneHeight):
        return QFont("Segoe UI", sceneHeight * .08, 10)

    def body_font(self, sceneHeight):
        return QFont("Segoe UI", sceneHeight * .045, 10)

class Server(object):
    def index(self, title, album, artist, albumArt=None):
        global filename
        global view
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
        view.thread.set_data({'title': title,
                              'artist': artist,
                              'album': album})
        view.thread.emit(SIGNAL("dataReady()"))
        print out
        return out
    index.exposed = True


class MainThread(QThread):

    def get_data(self):
        QMutexLocker(self.mutex)
        return deepcopy(self.data)

    def set_data(self, data):
        QMutexLocker(self.mutex)
        self.data = deepcopy(data)

    def run(self):
        self.mutex = QMutex()
        cherrypy.tree.mount(Server())
        cherrypy.engine.start()


class MetroView(QGraphicsView):
    slots = ('album', 'title', 'artist', 'albumart', 'data')

    def __init__(self, scene, parent=None):
        super(MetroView, self).__init__(scene, parent)
        self.thread = MainThread()
        self.connect(self.thread, SIGNAL("dataReady()"), self.update)
        self.thread.start()
        self.initUI()

    def initUI(self):
        # set blackish background

        self.albumart = QPixmap(filename).scaledToHeight(self.scene().sceneRect().height())
        self.setWindowFlags(Qt.FramelessWindowHint)

        self.title = QGraphicsTextItem()
        self.title.setAcceptHoverEvents(False)
        self.title.setFont(Style().title_font(self.scene().sceneRect().height()))
        self.title.setPlainText("It's Alright")
        self.title.setDefaultTextColor(Style.ui_text_color)
        self.title.setPos(20, self.scene().sceneRect().height() - self.scene().sceneRect().height() * .20)
        self.scene().addItem(self.title)

        self.album = QGraphicsTextItem()
        self.album.setAcceptHoverEvents(False)
        self.album.setFont(Style().body_font(self.scene().sceneRect().height()))
        self.album.setPlainText("%s - %s" % ('Matt and Kim', 'Lightning'))
        self.album.setDefaultTextColor(Style.ui_text_color)
        self.album.setPos(20, self.scene().sceneRect().height() - self.scene().sceneRect().height() * .09)
        self.scene().addItem(self.album)

    def updateImage(self):
        self.albumart = QPixmap(filename).scaledToHeight(self.scene().sceneRect().height())
        #color = colorz(filename, 2)[1]
        #self.title.setDefaultTextColor(color)
        #self.album.setDefaultTextColor(color)

    def updateArtistAlbum(self, artist, album):
        self.album.setPlainText("%s - %s" % (artist, album))

    def updateTitle(self, title):
        self.title.setPlainText(title)

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.drawTiledPixmap(self.rect(), self.albumart)
        painter.setBrush(Style.background_color)
        painter.setPen(QPen(Style.background_color, 0, Qt.SolidLine, Qt.RoundCap, Qt.RoundJoin))
        painter.fillRect(QRect(0, self.scene().sceneRect().height() - self.scene().sceneRect().height() * .20,
                               self.scene().sceneRect().width(),
                               self.scene().sceneRect().height()), Style.background_color)
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
view.show()  # FullScreen()

app.exec_()


