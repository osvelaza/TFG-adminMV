import sys
from PySide6.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QTabWidget, QWidget, QLabel,QComboBox,QPushButton, QLineEdit
from PySide6.QtUiTools import QUiLoader
import utils
import launcher

def init_tab1(tab1,window):
    layout = QVBoxLayout(tab1)
    layout.addWidget(window)

def init_tab2(tab2,window):
    layout = QVBoxLayout(tab2)
    utils.guestInfo(window)
    layout.addWidget(window)

app = QApplication(sys.argv)

# Crear la ventana principal
window = QMainWindow()
window.setWindowTitle('VM manager')
window.setGeometry(100, 100, 900, 600)

#Pestaña creación imágenes Packer
loader = QUiLoader()
windowCre = loader.load("programa.ui", None)
contrasena=windowCre.findChild(QLineEdit,'contrasena')
contrasena.setEchoMode(QLineEdit.Password)

windowCre.Packer.clicked.connect(lambda: launcher.launchPacker(windowCre))

#Pestaña gestión MV
loader2 = QUiLoader()
windowGest = loader2.load("ventana2.ui", None)
windowGest.updateVM.clicked.connect(lambda: utils.guestInfo(windowGest))

#Llamar la función cada vez que se cambie la opción del ComboBox
comboBox=windowCre.findChild(QComboBox, 'comboboxDistro')
comboBox.currentIndexChanged.connect(lambda index: utils.mostrarVersionSistemaBox(windowCre))

# Widget central
central_widget = QWidget()
window.setCentralWidget(central_widget)

# Layout principal
layout = QVBoxLayout(central_widget)

# Crear el QTabWidget
tab_widget = QTabWidget()
tab1 = QWidget()
tab2 = QWidget()

tab_widget.addTab(tab1, "Creación")
tab_widget.addTab(tab2, "Gestión")

# Inicializar las pestañas
init_tab1(tab1,windowCre)
init_tab2(tab2,windowGest)

# Añadir el QTabWidget al layout
layout.addWidget(tab_widget)

# Mostrar la ventana
window.show()
sys.exit(app.exec())
