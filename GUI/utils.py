import sys
import subprocess
from PySide6.QtCore import QProcess
from PySide6.QtWidgets import QApplication,QLabel,QVBoxLayout,QPushButton,QComboBox,QLineEdit,QSpinBox
from PySide6.QtUiTools import QUiLoader
from PySide6.QtGui import QPixmap,QIcon
import launcher

def guestInfo(window):
    #Variables
    nombresVM=[]
    
    resultado=subprocess.run(["bash","../newTes/virshManageNombre.sh"],
    capture_output=True,
    text=True).stdout

    contador=1
    
    layout = window.findChild(QVBoxLayout, 'verticalLayout_nom')

    #Eliminar widgets internos del layout para evitar duplicación elementos
    while layout.count():
        elemento=layout.takeAt(0)
        widget=elemento.widget()
        if widget is not None:
            widget.deleteLater()

    #Por cada elemento crear un widget
    lines = resultado.split('\n')
    for line in lines:
        if line:
            concatenado='nombre'+str(contador)

            nombresVM.append(line)

            label = QLabel(concatenado)
            label.setObjectName(concatenado)
            label.setText(line)
                
            # Crear el QLabel solo si no existe
            layout.setSpacing(10)
            layout.addWidget(label)

            contador+=1

    resultado=subprocess.run(["bash","../newTes/virshManageEstado.sh"],
    capture_output=True,
    text=True).stdout

    contador=1

    layout = window.findChild(QVBoxLayout, 'verticalLayout_estado')
    #Eliminar widgets internos del layout para evitar duplicación elementos
    while layout.count():
        elemento=layout.takeAt(0)
        widget=elemento.widget()
        if widget is not None:
            widget.deleteLater()

    lines = resultado.split('\n')

    for line in lines:

        estadoVMActual=""

        if line:
            concatenado='estado'+str(contador)

            if line == 'apagado':
                pixmap = QPixmap('play.png')
                estadoVMActual="play.png"
            else:
                pixmap = QPixmap('stop.webp')
                estadoVMActual="stop.webp"

            icono = QIcon(pixmap)

            # Crear el QLabel solo si no existe
            boton = QPushButton()
            boton.setObjectName(concatenado)
            boton.setIcon(icono)
            layout = window.findChild(QVBoxLayout, 'verticalLayout_estado')
            layout.setSpacing(10)
            layout.addWidget(boton)

            setattr(window, concatenado, boton)

            if estadoVMActual=="play.png":
                boton = getattr(window, concatenado)
                boton.clicked.connect(lambda _, c=contador: launcher.startVM(nombresVM[c-1], window))
            else:
                boton = getattr(window, concatenado, None)
                boton.clicked.connect(lambda _, c=contador: launcher.stopVM(nombresVM[c-1], window))
                #print(nombresVM[contador-2],"test")
                #window.str(concatenado).clicked.connect(lambda: stopVM(nombresVM[contador]))
                #boton.clicked.connect(lambda: stopVM(nombresVM[contador-2],window))

            contador+=1

def mostrarVersionSistemaBox(window):
    comboBox=window.findChild(QComboBox, 'comboboxDistro')
    distro = comboBox.currentText()

    version=window.findChild(QComboBox, 'comboBoxVersion')

    if distro=='ubuntu':
        print('ubuntu')
        version.clear()
        version.insertItem(1, "")
        version.insertItem(2, "20.04")
        version.insertItem(3, "22.04")
        version.insertItem(4, "24.04")
    elif distro=='fedora':
        print('fedora')
        version.clear()
        version.insertItem(1, "")
        version.insertItem(2, "42 server")
    elif distro=='debian':
        print('debian')
        version.clear()
        version.insertItem(1, "")
        version.insertItem(2, "12")
        version.insertItem(2, "13")

def editPackerHcl(window):
    widget=window.findChild(QLineEdit, 'nombre')
    texto=widget.text()
    widget=window.findChild(QLineEdit, 'usuario')
    usuario=widget.text()
    widget=window.findChild(QLineEdit, 'contrasena')
    contrasena=widget.text()
    widget=window.findChild(QLineEdit, 'memoria')
    ram=widget.text()
    widget=window.findChild(QSpinBox, 'almacenamiento')
    disco=widget.value()
    widget=window.findChild(QSpinBox, 'CPU')
    cpu=widget.value()

    comboBoxDistro=window.findChild(QComboBox, 'comboboxDistro')
    comboBoxVersion=window.findChild(QComboBox, 'comboBoxVersion')
    comboBoxExtra=window.findChild(QComboBox, 'comboBoxExtra')

    distro=comboBoxDistro.currentText()
    version=comboBoxVersion.currentText()
    extra=comboBoxExtra.currentText()
    ruta=distro+version+extra

    ruta_pasar="../personalizados/"+texto+"/launch.sh"

    subprocess.call(["bash", "../newTes/editFileCustom.sh",ruta,texto,usuario,contrasena,str(cpu),ram,str(disco)])

    return ruta_pasar

#app = QApplication(sys.argv)
#loader2 = QUiLoader()
#windowGest = loader2.load("ventana2.ui", None)
#guestInfo(windowGest)
#windowGest.show()
#sys.exit(app.exec())